# Alfred v.1.2.2

# Welcome to OPA Alfred! The reasonably usable self-hosted alternative to OPA's Playground

# Enter your policy below

package play

default hello = false

hello if {
    m := input.message
    m == "Hello World!!!"
}
