module ParsingTests

include("../src/PropositionalLogic.jl")
using .PropositionalLogic.Types
using .PropositionalLogic.Parsing

using Test

@testset "Parsing" begin

    @testset "Atom" begin

        @test parseform("a") == Atom("a")

    end

    @testset "Negation" begin

        @test parseform("!a") == not(Atom("a"))
        @test parseform("!!a") == not(not(Atom("a")))

    end

    @testset "Disjunction" begin

        @test parseform("a|b") == or("a", "b")

    end

    @testset "Conjunction" begin

        @test parseform("a&b") == and("a", "b")

    end

    @testset "Implication" begin

        @test parseform("a>b") == implies("a", "b")

    end

    @testset "Biconditional" begin

        @test parseform("a<>b") == equals("a", "b")

    end

end

end
