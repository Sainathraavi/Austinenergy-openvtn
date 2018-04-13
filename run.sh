#!/bin/bash
#rake assets:precompile
puma --port $PORT --environment $RAILS_ENV
