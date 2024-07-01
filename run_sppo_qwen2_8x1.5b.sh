#!/bin/bash
iter_num=3
for i in $(seq 1 $iter_num); do
    if [ "$i" -eq 1 ]; then
        MODEL="xDAN2099/xDAN-L1-qwen2_moe-8x1.5b-Instruct-0701"
    else
        MODEL=$OUTPUT_DIR
    fi
    OUTPUT_DIR="checkpoints/xDAN-L1-qwen2_moe-8x1.5b-Iter${i}"
    PROMPT="UCLA-AGI/data-mistral-7b-instruct-sppo-iter${i}"
    OUT="data-xDAN-L1-qwen2_moe-8x1.5b-iter${i}"

    bash scripts/generate.sh --model $MODEL --prompt $PROMPT --out_path $OUT
    bash scripts/pipeline.sh --model $MODEL --iter $i --dataset "synthetic_data_xDAN-L1-qwen2_moe-8x1.5b-sppo-iter${i}_score" --output_dir $OUTPUT_DIR --num 1
done
