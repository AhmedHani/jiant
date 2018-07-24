#!/bin/bash

# Script to run edge probing on ELMo char-CNN only.
# Run as separate experiments, since datasets are disjoint anyway.

function run_exp() {
    OVERRIDES="exp_name=elmo-chars-$1, run_name=run_attn"
    OVERRIDES+=", train_tasks=$1, edges-tmpl.classifier_span_pooling=attn"
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

sudo poweroff
