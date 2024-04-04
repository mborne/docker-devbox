#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm -n kyverno delete kyverno-policies
helm -n kyverno delete kyverno
