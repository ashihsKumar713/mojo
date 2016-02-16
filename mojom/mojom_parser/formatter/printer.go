// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package formatter

import (
	"bytes"
	"fmt"
	"mojom/mojom_parser/lexer"
	"mojom/mojom_parser/mojom"
	"sort"
	"strings"
)

// printer is a single-use struct that keeps track of the state necessary to
// pretty-print a mojom file.
// It is used by FormatMojom (see formatter.go)
//
// Internall, the entry point is writeMojomFile and the result is obtained by
// calling result.
//
// The pretty-printing of individual elements is implemented using the write.*
// methods. Those methods accept the element to be printed (or the element
// of which a portion is to be printed) and write the pretty-printed output
// to |buffer|.
type printer struct {
	// used indicates whether the printer has been used or not. If set to true,
	// writeMojomFile will panic.
	used bool

	// buffer is the buffer to which the write.* methods write the pretty-printed
	// mojom file element.
	buffer bytes.Buffer

	// indentLevel is the current depth of indentation.
	indentLevel int

	// eolComment is the comment to be printed at the end of the current line.
	eolComment *lexer.Token

	// lineStarted is false if nothing has been written on the current line yet.
	lineStarted bool
}

// newPrinter is a constructor for printer.
func newPrinter() (p *printer) {
	p = new(printer)
	return
}

// result returns the pretty-printed version of what was given to the printer.
// Usually, this is a pretty-printed MojomFile.
func (p *printer) result() string {
	return p.buffer.String()
}

// writeMojomFile is the entry point of the pretty printer.
// It takes a mojom file with attached comments and creates a pretty-printed
// representation.
func (p *printer) writeMojomFile(mojomFile *mojom.MojomFile) {
	if p.used {
		panic("A printer can only be used once!")
	}
	p.used = true

	p.writeAttributes(mojomFile.Attributes)
	p.writeModuleNamespace(mojomFile.ModuleNamespace)

	if len(mojomFile.Imports) > 0 {
		p.nl()
		p.writeImportedFiles(mojomFile.Imports)
	}

	if len(mojomFile.DeclaredObjects) > 0 {
		p.nl()
	}

	for i, declaredObject := range mojomFile.DeclaredObjects {
		p.writeDeclaredObject(declaredObject)
		if i < len(mojomFile.DeclaredObjects)-1 {
			p.nl()
		}
	}

	if mojomFile.FinalComments != nil {
		p.nl()
		p.writeCommentBlocks(mojomFile.FinalComments)
	}
}

// writeModuleNamespace writes a mojom file's module statement and associated
// comments.
func (p *printer) writeModuleNamespace(module *mojom.ModuleNamespace) {
	p.writeBeforeComments(module)
	p.writef("module %s;", module.Identifier)
	p.writeRightComments(module)
	p.nl()
}

// writeImportedFiles sorts and writes a slice of import statements.
func (p *printer) writeImportedFiles(imports []*mojom.ImportedFile) {
	// TODO(azani): Detect and handle separate blocks of imports.
	sortImportedFiles(imports)
	for _, imported := range imports {
		p.writeBeforeComments(imported)
		p.writef("import \"%v\";", imported.SpecifiedName)
		p.writeRightComments(imported)
		p.nl()
	}
}

// writeDeclaredObject writes a declared object's attributes, then its
// preceeding comments and finally the object itself.
func (p *printer) writeDeclaredObject(declaredObject mojom.DeclaredObject) {
	p.writeAttributes(declaredObject.Attributes())
	p.writeBeforeComments(declaredObject)
	switch o := declaredObject.(type) {
	case *mojom.MojomStruct:
		p.writeMojomStruct(o)
	case *mojom.StructField:
		p.writeStructField(o)
	case *mojom.MojomUnion:
		p.writeMojomUnion(o)
	case *mojom.UnionField:
		p.writeUnionField(o)
	case *mojom.MojomEnum:
		p.writeMojomEnum(o)
	case *mojom.EnumValue:
		p.writeEnumValue(o)
	case *mojom.UserDefinedConstant:
		p.writeUserDefinedConstant(o)
	case *mojom.MojomInterface:
		p.writeMojomInterface(o)
	case *mojom.MojomMethod:
		p.writeMojomMethod(o)
	default:
		panic(fmt.Sprintf("writeDeclaredObject cannot write %v.", declaredObject))
	}
}

func (p *printer) writeMojomStruct(mojomStruct *mojom.MojomStruct) {
	p.write("struct ")
	p.writeDeclaredObjectsContainer(mojomStruct)
}

func (p *printer) writeMojomUnion(mojomUnion *mojom.MojomUnion) {
	p.write("union ")
	p.writeDeclaredObjectsContainer(mojomUnion)
}

func (p *printer) writeMojomEnum(mojomEnum *mojom.MojomEnum) {
	p.write("enum ")
	p.writeDeclaredObjectsContainer(mojomEnum)
}

func (p *printer) writeMojomInterface(mojomInterface *mojom.MojomInterface) {
	p.write("interface ")
	p.writeDeclaredObjectsContainer(mojomInterface)
}

func (p *printer) writeMojomMethod(mojomMethod *mojom.MojomMethod) {
	p.write(mojomMethod.NameToken().Text)
	p.writeMethodParams(mojomMethod.Parameters)
	if mojomMethod.ResponseParameters != nil && len(mojomMethod.ResponseParameters.Fields) > 0 {
		p.write(" => ")
		p.writeMethodParams(mojomMethod.ResponseParameters)
	}
	p.write(";")
	p.writeRightComments(mojomMethod)
}

// writeMethodParams writes the pretty-printed method parameters represented by
// a MojomStruct.
func (p *printer) writeMethodParams(params *mojom.MojomStruct) {
	p.write("(")
	declaredObjects := params.GetDeclaredObjects()
	for i, param := range declaredObjects {
		p.writeMethodParam(param.(*mojom.StructField))
		if i < len(declaredObjects)-1 {
			p.write(", ")
		}
	}

	p.write(")")
}

// writeMethodParam writes a single pretty-printed method parameter represented
// by a StructField.
func (p *printer) writeMethodParam(param *mojom.StructField) {
	p.writeAttributes(param.Attributes())
	p.writeBeforeComments(param)
	p.writeTypeRef(param.FieldType)
	p.writef(" %v", param.NameToken().Text)
	if param.DefaultValue != nil {
		p.write("=")
		p.writeValueRef(param.DefaultValue)
	}
	p.writeRightComments(param)
}

func (p *printer) writeUserDefinedConstant(constant *mojom.UserDefinedConstant) {
	p.write("const ")
	p.writeTypeRef(constant.DeclaredType())
	p.writef(" %s", constant.NameToken().Text)
	p.write(" = ")
	p.writeValueRef(constant.ValueRef())
	p.write(";")
	p.writeRightComments(constant)
	p.nl()
}

func (p *printer) writeStructField(structField *mojom.StructField) {
	p.writeTypeRef(structField.FieldType)
	p.writef(" %v", structField.NameToken().Text)
	if structField.DeclaredOrdinal() >= 0 {
		p.writef("@%v", structField.DeclaredOrdinal())
	}
	if structField.DefaultValue != nil {
		p.write(" = ")
		p.writeValueRef(structField.DefaultValue)
	}
	p.write(";")
	p.writeRightComments(structField)
}

func (p *printer) writeUnionField(unionField *mojom.UnionField) {
	p.writeTypeRef(unionField.FieldType)
	p.writef(" %v", unionField.NameToken().Text)
	if unionField.DeclaredOrdinal() >= 0 {
		p.writef("@%v", unionField.DeclaredOrdinal())
	}
	p.write(";")
	p.writeRightComments(unionField)
}

func (p *printer) writeEnumValue(enumValue *mojom.EnumValue) {
	p.write(enumValue.NameToken().Text)
	if enumValue.ValueRef() != nil {
		p.write(" = ")
		p.writeValueRef(enumValue.ValueRef())
	}
	p.write(",")
}

// writeDeclaredObjectsContainer
// DeclaredObjectsContainers are MojomEnum, MojomUnion, MojomInterface, MojomStruct.
// This method writes the name of the object, an opening brace, the contained
// declarations (fields, enum values, nested declarations and methods) and the
// closing brace.
func (p *printer) writeDeclaredObjectsContainer(container mojom.DeclaredObjectsContainer) {
	// TODO(azani): Detect when a blank line should separate two declared objects.
	p.writef("%v {", container.(mojom.DeclaredObject).NameToken().Text)
	p.writeRightComments(container.(mojom.MojomElement))
	p.incIndent()
	p.nl()
	declaredObjects := container.GetDeclaredObjects()
	for i, declaredObject := range declaredObjects {
		p.writeDeclaredObject(declaredObject)
		if i < len(declaredObjects)-1 {
			p.nl()
		}
	}

	p.decIndent()
	p.nl()
	p.write("};")
	p.nl()
}

func (p *printer) writeAttributes(attrs *mojom.Attributes) {
	if attrs == nil || len(attrs.List) == 0 {
		return
	}

	p.writef("[")
	for idx, attr := range attrs.List {
		p.writeAttribute(&attr)
		if idx < len(attrs.List)-1 {
			p.writef(",")
			p.nl()
		}
	}
	p.writef("]")
}

func (p *printer) writeAttribute(attr *mojom.MojomAttribute) {
	p.writef("%s=", attr.Key)
	p.writeValueRef(attr.Value)
}

func (p *printer) writeTypeRef(t mojom.TypeRef) {
	switch t.TypeRefKind() {
	case mojom.TypeKindUserDefined:
		u := t.(*mojom.UserTypeRef)
		p.write(u.Identifier())
		if u.Nullable() {
			p.write("?")
		}
	case mojom.TypeKindArray:
		a := t.(*mojom.ArrayTypeRef)
		p.write("array<")
		p.writeTypeRef(a.ElementType())
		if a.FixedLength() >= 0 {
			p.writef(", %v", a.FixedLength())
		}
		p.write(">")
		if a.Nullable() {
			p.write("?")
		}
	case mojom.TypeKindMap:
		m := t.(*mojom.MapTypeRef)
		p.write("map<")
		p.writeTypeRef(m.KeyType())
		p.write(", ")
		p.writeTypeRef(m.ValueType())
		p.write(">")
		if m.Nullable() {
			p.write("?")
		}
	case mojom.TypeKindHandle:
		fallthrough
	case mojom.TypeKindSimple:
		fallthrough
	case mojom.TypeKindString:
		p.write(t.String())
	default:
		panic("This unhandled TypeRefKind: " + t.String())
	}
}

func (p *printer) writeValueRef(value mojom.ValueRef) {
	switch v := value.(type) {
	case mojom.LiteralValue:
		p.write(v.String())
	case *mojom.UserValueRef:
		p.write(v.Identifier())
	default:
		panic("Cannot handle this value ref.")
	}
}

// writeBeforeComments writes the comments preceeding a MojomElement.
func (p *printer) writeBeforeComments(el mojom.MojomElement) {
	attachedComments := el.AttachedComments()
	if attachedComments == nil {
		return
	}

	p.writeAboveComments(el)
	p.writeLeftComments(el)
}

// writeAboveComments writes the comments above of a MojomElement.
func (p *printer) writeAboveComments(el mojom.MojomElement) {
	attachedComments := el.AttachedComments()
	if attachedComments == nil {
		return
	}

	p.writeCommentBlocks(attachedComments.Above)
}

// writeLeftComments writes the comments left of a MojomElement.
func (p *printer) writeLeftComments(el mojom.MojomElement) {
	attachedComments := el.AttachedComments()
	if attachedComments == nil {
		return
	}

	for _, comment := range attachedComments.Left {
		if comment.Kind == lexer.SingleLineComment {
			panic("SingleLineComment cannot be on the left of an element.")
		}

		p.writef("%s ", comment.Text)
	}
}

// writeRightComments writes the comments to the right of a MojomElement.
func (p *printer) writeRightComments(el mojom.MojomElement) {
	attachedComments := el.AttachedComments()
	if attachedComments == nil {
		return
	}

	for i, comment := range attachedComments.Right {
		if comment.Kind == lexer.SingleLineComment {
			if i < len(attachedComments.Right)-1 {
				panic("You can't have anything after a SingleLineComment!")
			}
			p.setEolComment(comment)
			break
		}
		p.writef(" %s", comment.Text)
	}

}

func (p *printer) writeCommentBlocks(comments []lexer.Token) {
	for i, comment := range comments {
		if i != 0 &&
			(comment.LineNo > comments[i-1].LineNo+1 ||
				comment.Kind == lexer.MultiLineComment ||
				comments[i-1].Kind == lexer.MultiLineComment) {
			// New block.
			p.nl()
		}
		switch comment.Kind {
		case lexer.SingleLineComment:
			p.write(comment.Text)
			p.nl()
		case lexer.MultiLineComment:
			p.writeMultiLineComment(comment)
		default:
			panic(fmt.Sprintf("%s is not a comment.", comment))
		}
	}
}

func (p *printer) writeMultiLineComment(comment lexer.Token) {
	if comment.Kind != lexer.MultiLineComment {
		panic(fmt.Sprintf("This is not a MultiLineComment: %s", comment))
	}

	for i, line := range strings.Split(comment.Text, "\n") {
		if i != 0 {
			p.write("   ")
		}
		p.write(strings.Trim(line, " "))
		p.nl()
	}
}

// Utility functions

// writef writes according to the format specifier. See fmt.Printf for the
// format specifier.
func (p *printer) writef(format string, a ...interface{}) {
	p.write(fmt.Sprintf(format, a...))
}

// write writes the provided string to the buffer.
// If nothing has been written yet on the current line write also writes the
// current indentation level.
func (p *printer) write(s string) {
	if strings.ContainsRune(s, '\n') {
		panic(fmt.Sprintf("Only the nl method can write a new line: %q", s))
	}

	// We only print the indentation if the line is not empty.
	if !p.lineStarted {
		p.buffer.WriteString(strings.Repeat("  ", p.indentLevel))
		p.lineStarted = true
	}
	p.buffer.WriteString(s)
}

// nl writes a new line. Before writing the new line, nl writes the last
// comment on the line.
func (p *printer) nl() {
	// Before going to the next line, print the last comment on the line.
	if p.eolComment != nil {
		p.writef(" %s", p.eolComment.Text)
		p.eolComment = nil
	}

	p.buffer.WriteString("\n")
	p.lineStarted = false
}

func (p *printer) incIndent() {
	p.indentLevel += 1
}

func (p *printer) decIndent() {
	if p.indentLevel == 0 {
		panic("The printer is attempting to use negative indentation!")
	}
	p.indentLevel -= 1
}

// setEolComment sets the comment that is to be printed at the end of the current line.
// The last comment on the line is not necessarily associated with the last
// element on the line. So when the last comment is found, we record that
// comment so we may print it right before going to the next line.
func (p *printer) setEolComment(comment lexer.Token) {
	if p.eolComment != nil {
		panic("There is space for only one comment at the end of the line!")
	}

	if comment.Kind != lexer.SingleLineComment {
		panic("Only SingleLineComments need to be handled specially at the end of line.")
	}

	p.eolComment = &comment
}

// Following is a utility to sort slices of |ImportedFile|s.

// sortImportedFiles sorts the slice of imported files it receives.
func sortImportedFiles(imports []*mojom.ImportedFile) {
	sort.Sort(&importedFilesSorter{imports})
}

type importedFilesSorter struct {
	imports []*mojom.ImportedFile
}

// See sort.Interface.
func (ifs *importedFilesSorter) Len() int {
	return len(ifs.imports)
}

// See sort.Interface.
func (ifs *importedFilesSorter) Less(i, j int) bool {
	return ifs.imports[i].SpecifiedName < ifs.imports[j].SpecifiedName
}

// See sort.Interface.
func (ifs *importedFilesSorter) Swap(i, j int) {
	ifs.imports[i], ifs.imports[j] = ifs.imports[j], ifs.imports[i]
}