module Syntax

"Propositional formula supertype."
abstract type Formula end
export Formula

"Propostional constant supertype."
abstract type Constant <: Formula end
export Constant

"Propositional tautology type."
struct Tautology <: Constant end
export Tautology
const ⊤ = Tautology()
export ⊤
const tautology = Tautology()
export tautology
Base.show(io::IO, ::Tautology) = show(io, "⊤")
Base.print(io::IO, ::Tautology) = print(io, "⊤")

"Propositional contradiction type."
struct Contradiction <: Constant end
export Contradiction
const ⊥ = Contradiction()
export ⊥
const contradiction = Contradiction()
export contradiction
Base.show(io::IO, ::Contradiction) = show(io, "⊥")
Base.print(io::IO, ::Contradiction) = print(io, "⊥")

"Propositional atom type."
struct Atom <: Formula
    name::Union{String, Int}
    Atom(n::Int) = new(n)
    Atom(n::SubString) = new(string(n))
    Atom(n::String) = new(n)
    Atom(n::Char) = new(string(n))
end
export Atom
name(α::Atom)::Union{String, Int} = α.name
export name
Base.convert(::Type{Formula}, x::Union{String, Char, Int}) = Atom(x)
Base.show(io::IO, a::Atom) = show(io, name(a))
Base.print(io::IO, a::Atom) = print(io, name(a))

"Propostional operator supertype."
abstract type Operator end
export Operator

"Propositional operation supertype."
abstract type Operation <: Formula end
export Operation
operator(operation::Operation) = operation.operator
export operator

"Propositional unary operator supertype."
abstract type UnaryOperator <: Operator end
export UnaryOperator

"Propositional unary operation type."
struct UnaryOperation{OpType<:UnaryOperator, FormulaType<:Formula} <: Operation
    operator::OpType
    operand::FormulaType
end
export UnaryOperation
operand(operation::UnaryOperation) = operation.operand
export operand
function Base.show(io::IO, z::UnaryOperation)
    show(io, operator(z))
    show(io, operand(z))
end
function Base.print(io::IO, z::UnaryOperation)
    print(io, operator(z))
    print(io, operand(z))
end

"Propositional negation unary operator type."
struct Negation <: UnaryOperator end
export Negation
negation = Negation()
export negation
Base.show(io::IO, ::Negation) = show(io, "¬")
Base.print(io::IO, ::Negation) = print(io, "¬")
not(α::Union{Formula,String}) = UnaryOperation(
    Negation(),
    α isa String ? Atom(α) : α
)
export not
const ¬ = not
export ¬

"Propositional binary operator supertype."
abstract type BinaryOperator <: Operator end
export BinaryOperator

"Propositional binary operation type."
struct BinaryOperation{OpType<:BinaryOperator, LFormulaType<:Formula, RFormulaType<:Formula} <: Operation
    operator::OpType
    operand1::LFormulaType
    operand2::RFormulaType
end
export BinaryOperation
operand1(operation::BinaryOperation) = operation.operand1
export operand1
operand2(operation::BinaryOperation) = operation.operand2
export operand2
function Base.show(io::IO, z::BinaryOperation)
    show(io, "(")
    show(io, operand1(z))
    show(io, operator(z))
    show(io, operand2(z))
    show(io, ")")
end
function Base.print(io::IO, z::BinaryOperation)
    print(io, "(")
    print(io, operand1(z))
    print(io, operator(z))
    print(io, operand2(z))
    print(io, ")")
end

"Propositional disjunction operator type."
struct Disjunction <: BinaryOperator end
export Disjunction
const disjunction = Disjunction()
export disjunction
Base.show(io::IO, ::Disjunction) = show(io, "∨")
Base.print(io::IO, ::Disjunction) = print(io, "∨")
or(α::Union{Formula,String}, β::Union{Formula,String}) = BinaryOperation(
    Disjunction(), α isa String ? Atom(α) : α, β isa String ? Atom(β) : β
)
export or
const ∨ = or
export ∨

"Propositional conjunction operator type."
struct Conjunction <: BinaryOperator end
export Conjunction
const conjunction = Conjunction()
export conjunction
Base.show(io::IO, ::Conjunction) = show(io, "∧")
Base.print(io::IO, ::Conjunction) = print(io, "∧")
and(α::Union{Formula,String}, β::Union{Formula,String}) = BinaryOperation(
    Conjunction(), α isa String ? Atom(α) : α, β isa String ? Atom(β) : β
)
export and
const ∧ = and
export ∧

"Propositional implication operator type."
struct Implication <: BinaryOperator end
export Implication
const implication = Implication()
export implication
Base.show(io::IO, ::Implication) = show(io, "→")
Base.print(io::IO, ::Implication) = print(io, "→")
implies(α::Union{Formula,String}, β::Union{Formula,String}) = BinaryOperation(
    Implication(), α isa String ? Atom(α) : α, β isa String ? Atom(β) : β
)
export implies
const → = implies
export →

"Propositional biconditional operator type."
struct Biconditional <: BinaryOperator end
export Biconditional
const biconditional = Biconditional()
export biconditional
Base.show(io::IO, ::Biconditional) = show(io, "↔")
Base.print(io::IO, ::Biconditional) = print(io, "↔")
equals(α::Union{Formula,String}, β::Union{Formula,String}) = BinaryOperation(
    Biconditional(), α isa String ? Atom(α) : α, β isa String ? Atom(β) : β
)
export equals
const ↔ = equals
export ↔

end