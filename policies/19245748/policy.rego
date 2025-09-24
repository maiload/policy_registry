package policies.example

import rego.v1

default allow := false

allow if {
    input.method == "GET"
    input.path[0] == "public"
}

allow if {
    input.method == "GET"
    input.user.role == "admin"
}

allow if {
    input.method == "POST"
    input.path[0] == "api"
    input.user.role in ["admin", "editor"]
}

allow if {
    input.method == "DELETE"
    input.user.role == "admin"
}