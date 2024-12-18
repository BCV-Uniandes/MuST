
# Define variables
NUM_FRAMES=16
SAMPLE_RATE='1,8,16,32'
TASK="PHASES"
ARCH="MMViT"
TRAIN_FOLD="train"
TEST_FOLD="test"
ONLINE=True
EXP_PREFIX="arch_$ARCH-frames_$NUM_FRAMES-sr_$SAMPLE_RATE-online_$ONLINE"


#-------------------------
DATASET="cholec80"
EXPERIMENT_NAME=$EXP_PREFIX"/"$TRAIN_FOLD
CONFIG_PATH="configs/"$DATASET"/"$ARCH"_"$TASK".yaml"
FRAME_DIR="./data/"$DATASET"/frames"
OUTPUT_DIR="outputs/"$DATASET"/"$TASK"/"$EXPERIMENT_NAME
FRAME_LIST="./data/"$DATASET"/frame_lists"
ANNOT_DIR="./data/"$DATASET"/annotations/"$TRAIN_FOLD
COCO_ANN_PATH="./data/"$DATASET"/annotations/"$TRAIN_FOLD"/"$TEST_FOLD"_long-term_anns.json"
# Note: The MViT pretrained model on the same dataset.
CHECKPOINT="./model_weights/multiterm_frame_encoder/heichole/train/checkpoint_best_phases.pyth"

TYPE="pytorch"

#-------------------------
# Run experiment
export PYTHONPATH="./must:$PYTHONPATH"
mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=0,1,2 python -B tools/run_net.py \
--cfg $CONFIG_PATH \
NUM_GPUS 3 \
TRAIN.DATASET "Cholec80ms" \
TEST.DATASET "Cholec80ms" \
MULTISCALEATTN.CROSS_ATTN_DEPTH 2 \
MULTISCALEATTN.CROSS_ATTN_HEADS 2 \
MULTISCALEATTN.SELF_ATTN_LAYERS 2 \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
DATA.MULTI_SAMPLING_RATE $SAMPLE_RATE \
DATA.NUM_FRAMES $NUM_FRAMES \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
TEST.ENABLE False \
TRAIN.ENABLE True \
SOLVER.MAX_EPOCH 40 \
DATA.FIXED_RESIZE True \
SOLVER.EARLY_STOPPING 5 \
ENDOVIS_DATASET.FRAME_DIR $FRAME_DIR \
ENDOVIS_DATASET.FRAME_LIST_DIR $FRAME_LIST \
ENDOVIS_DATASET.TRAIN_LISTS $TRAIN_FOLD".csv" \
ENDOVIS_DATASET.TEST_LISTS $TEST_FOLD".csv" \
ENDOVIS_DATASET.ANNOTATION_DIR $ANNOT_DIR \
ENDOVIS_DATASET.TEST_COCO_ANNS $COCO_ANN_PATH \
ENDOVIS_DATASET.TRAIN_GT_BOX_JSON $TRAIN_FOLD"_long-term_anns.json" \
ENDOVIS_DATASET.TEST_GT_BOX_JSON $TEST_FOLD"_long-term_anns.json" \
TRAIN.BATCH_SIZE 18 \
TEST.BATCH_SIZE 18 \
OUTPUT_DIR $OUTPUT_DIR
