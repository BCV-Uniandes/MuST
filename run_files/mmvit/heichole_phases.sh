# Define variables
NUM_FRAMES=24
SAMPLE_RATE='1,2,4,6'
TASK="PHASES"
ARCH="MMViT"
TRAIN_FOLD="train"
TEST_FOLD="test"
ONLINE=True
EXP_PREFIX="arch_$ARCH-frames_$NUM_FRAMES-sr_$SAMPLE_RATE-online_$ONLINE"


#-------------------------
DATASET="heichole"
EXPERIMENT_NAME=$EXP_PREFIX"/"$TRAIN_FOLD
CONFIG_PATH="configs/"$DATASET"/"$ARCH"_"$TASK".yaml"
FRAME_DIR="./data/"$DATASET"/frames"
OUTPUT_DIR="outputs/"$DATASET"/"$TASK"/"$EXPERIMENT_NAME
FRAME_LIST="./data/"$DATASET"/frame_lists"
ANNOT_DIR="./data/"$DATASET"/annotations/"$TRAIN_FOLD
COCO_ANN_PATH="./data/"$DATASET"/annotations/"$TRAIN_FOLD"/"$TEST_FOLD"_long-term_anns.json"
# Note: The MViT pretrained model on the same dataset.
CHECKPOINT="./model_weights/mvit/heichole/$TRAIN_FOLD/checkpoint_best_phases.pyth"

TYPE="pytorch"
#-------------------------
# Run experiment

export PYTHONPATH="./must:$PYTHONPATH"

mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=0,2,3 python -B tools/run_net.py \
--cfg $CONFIG_PATH \
NUM_GPUS 3 \
TRAIN.DATASET "heicholems" \
TEST.DATASET "heicholems" \
DATA.MULTI_SAMPLING_RATE $SAMPLE_RATE \
DATA.NUM_FRAMES $NUM_FRAMES \
DATA.ONLINE $ONLINE \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
TEST.ENABLE False \
TRAIN.ENABLE True \
SOLVER.WARMUP_EPOCHS 0.0 \
SOLVER.BASE_LR 0.0001 \
SOLVER.WARMUP_START_LR 0.000125 \
SOLVER.COSINE_END_LR 0.00001 \
SOLVER.EARLY_STOPPING 5 \
ENDOVIS_DATASET.FRAME_DIR $FRAME_DIR \
ENDOVIS_DATASET.FRAME_LIST_DIR $FRAME_LIST \
ENDOVIS_DATASET.TRAIN_LISTS $TRAIN_FOLD".csv" \
ENDOVIS_DATASET.TEST_LISTS $TEST_FOLD".csv" \
ENDOVIS_DATASET.ANNOTATION_DIR $ANNOT_DIR \
ENDOVIS_DATASET.TEST_COCO_ANNS $COCO_ANN_PATH \
ENDOVIS_DATASET.TRAIN_GT_BOX_JSON $TRAIN_FOLD"_long-term_anns.json" \
ENDOVIS_DATASET.TEST_GT_BOX_JSON $TEST_FOLD"_long-term_anns.json" \
TRAIN.BATCH_SIZE 9 \
TEST.BATCH_SIZE 9 \
OUTPUT_DIR $OUTPUT_DIR