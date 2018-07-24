#!/bin/bash

# Script to run edge probing on ELMo-only.
# Run as separate experiments, since datasets are disjoint anyway.

function run_exp() {
    OVERRIDES="exp_name=elmo-full-$1, run_name=run-concat"
    OVERRIDES+=", train_tasks=$1, elmo_chars_only=0"
    OVERRIDES+=', edges-tmpl.classifier_span_pooling="x,y"'
    python main.py --config_file config/edgeprobe_bare.conf \
        -o "${OVERRIDES}" \
        --remote_log
}

set -eux

cd $(dirname $0)
pushd "${PWD%jiant*}/jiant"

run_exp "edges-srl-conll2005"
run_exp "edges-spr2"
run_exp "edges-dpr"
run_exp "edges-coref-ontonotes"
run_exp "edges-dep-labeling"

run_exp "edges-ner-conll2003"
run_exp "edges-constituent-ptb"
# run_exp "edges-ccg-tag"

sudo poweroff
