# This is a helper bash script. Execute run_stuff.sh, not this.

while getopts 'ivkmn:r:d:w:S:s:tvh:l:L:o:T:E:O:b:H:p:ecgP:qB:V:M:D:CX:GI:N:y:K:W:F:A:' flag; do
    case "${flag}" in
        P) PROJECT_PREFIX="${OPTARG}" ;;
        d) DATA_DIR=${OPTARGS} ;;
        n) EXP_NAME="${OPTARG}" ;;
        r) RUN_NAME="${OPTARG}" ;;
        w) word_embs="${OPTARG}" ;;
        C) char_embs=1 ;;
	    F) FASTTEXT_MODEL_FILE="${OPTARG}" ;;
        S) SEED="${OPTARG}" ;;
        q) no_tqdm=1 ;;
        t) SHOULD_TRAIN=0 ;;
        k) RELOAD_TASKS=1 ;;
        i) RELOAD_INDEX=1 ;;
        v) RELOAD_VOCAB=1 ;;
        m) LOAD_MODEL=1 ;;
        B) BPP_BASE="${OPTARG}" ;;
        V) VAL_INTERVAL="${OPTARG}" ;;
        X) MAX_VALS="${OPTARG}" ;;
        T) train_tasks="${OPTARG}" ;;
        E) eval_tasks="${OPTARG}" ;;
        O) TASK_ORDERING="${OPTARG}" ;;
        H) n_layers_highway="${OPTARG}" ;;
        A) n_heads="${OPTARG}" ;;
        l) LR="${OPTARG}" ;;
        #s) min_lr="${OPTARG}" ;;
        L) N_LAYERS_ENC="${OPTARG}" ;;
        o) OPTIMIZER="${OPTARG}" ;;
        h) d_hid="${OPTARG}" ;;
        b) BATCH_SIZE="${OPTARG}" ;;
        s) sent_enc="${OPTARG}" ;;
        #E) PAIR_ENC="${OPTARG}" ;;
        G) glove=0 ;;
        e) ELMO=1 ;;
        c) COVE=1 ;;
        D) dropout="${OPTARG}" ;;
        #C) CLASSIFIER="${OPTARG}" ;;
        I) GPUID="${OPTARG}" ;;
        N) FORCE_LOAD_EPOCH="${OPTARG}" ;;
        y) LR_DECAY="${OPTARG}" ;;
        K) task_patience="${OPTARG}" ;;
        p) patience="${OPTARG}" ;;
        W) weighting_method="${OPTARG}" ;;
        #s) scaling_method="${OPTARG}" ;;
    esac
done

EXP_DIR="${PROJECT_PREFIX}/${EXP_NAME}/"
RUN_DIR="${PROJECT_PREFIX}/${EXP_NAME}/${RUN_NAME}"
LOG_PATH="${RUN_DIR}/log.log"
mkdir -p ${EXP_DIR}
mkdir -p ${RUN_DIR}


ALLEN_CMD="python ../src/main.py --cuda ${GPUID} --random_seed ${SEED} --no_tqdm ${no_tqdm} --log_file ${LOG_PATH} --data_dir ${DATA_DIR} --exp_dir ${EXP_DIR} --run_dir ${RUN_DIR} --train_tasks ${train_tasks} --eval_tasks ${eval_tasks} --classifier ${CLASSIFIER} --classifier_hid_dim ${d_hid_cls} --max_seq_len ${max_seq_len} --max_word_v_size ${VOCAB_SIZE} --word_embs ${word_embs} --word_embs_file ${WORD_EMBS_FILE} --fastText_model_file ${FASTTEXT_MODEL_FILE} --fastText ${fastText} --char_embs ${char_embs} --elmo ${ELMO} --deep_elmo ${deep_elmo} --cove ${COVE} --d_word ${d_word} --d_hid ${d_hid} --sent_enc ${sent_enc} --n_layers_enc ${N_LAYERS_ENC} --pair_enc ${PAIR_ENC} --n_layers_highway ${n_layers_highway} --n_heads ${n_heads} --batch_size ${BATCH_SIZE} --bpp_base ${BPP_BASE} --optimizer ${OPTIMIZER} --lr ${LR} --min_lr ${min_lr} --lr_decay_factor ${LR_DECAY} --task_patience ${task_patience} --patience ${patience} --weight_decay ${WEIGHT_DECAY} --dropout ${dropout} --val_interval ${VAL_INTERVAL} --max_vals ${MAX_VALS} --weighting_method ${weighting_method} --scaling_method ${scaling_method} --scheduler_threshold ${SCHED_THRESH} --load_model ${LOAD_MODEL} --reload_tasks ${RELOAD_TASKS} --reload_indexing ${RELOAD_INDEX} --reload_vocab ${RELOAD_VOCAB} --should_train ${SHOULD_TRAIN} --force_load_epoch ${FORCE_LOAD_EPOCH}"
eval ${ALLEN_CMD}
