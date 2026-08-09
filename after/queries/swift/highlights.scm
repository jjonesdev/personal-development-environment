; extends

; Xcode colors declaration names separately from the pink declaration keyword.
(class_declaration
  name: (type_identifier) @type.declaration)

(protocol_declaration
  name: (type_identifier) @type.declaration)

(typealias_declaration
  name: (type_identifier) @type.declaration)

(associatedtype_declaration
  name: (type_identifier) @type.declaration)

(function_declaration
  name: (simple_identifier) @function.declaration)

(protocol_function_declaration
  name: (simple_identifier) @function.declaration)
