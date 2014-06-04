#!/bin/env/bash

email="zs1213yh@gmail.com"

ssh-keygen -t rsa -C "$email"

ssh-add ~/.ssh/id_rsa

