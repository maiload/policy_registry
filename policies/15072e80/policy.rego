package policies.request

import rego.v1

default allow := false

allow if {
    input.path[0] == "api"
}

allow if {
    input.method == "DELETE"
    input.user.role == "admin"
}