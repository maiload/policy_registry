package policies.request

import rego.v1

default allow := false

allow if {
    input.method == "GET"
    input.path[0] == "api"
}

allow if {
    input.method == "POST"
    input.path[0] == "api"
}

allow if {
    input.method == "DELETE"
    input.user.role == "admin"
}