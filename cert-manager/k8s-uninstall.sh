#!/bin/bash

# Deploy cert-manager with helm
helm -n cert-manager uninstall cert-manager
