# Experiment setup
TRAIN_FOLD="train"
TEST_FOLD="test" 
EXP_PREFIX="metric_trial_no_preload"
TASK="PHASES"
ARCH="TCM"

# TCM
S_HEADS=2
S_LAYERS=2
S_CAT_DIM=768
S_D_MODEL=512
S_INPUT_DIM=3072

CHUNK_SIZE=600
OVERLAPPING=500

OPT="adam"
LR=0.0001

DATASET="GraSP"

EXPERIMENT_NAME="$ARCH-chunks_$CHUNK_SIZE-overlap_$OVERLAPPING-dmodel_$S_D_MODEL-catdim_$S_CAT_DIM-layers_$S_LAYERS-heads_$S_HEADS-opt_$OPT-lr_$LR"
CONFIG_PATH="configs/"$DATASET"/"$ARCH"_"$TASK".yaml"
FRAME_DIR="./data/"$DATASET"/frames"
OUTPUT_DIR="outputs/$DATASET/"$TRAIN_FOLD"/"$TASK"/"$EXPERIMENT_NAME
FRAME_LIST="./data/"$DATASET"/frame_lists"
ANNOT_DIR="./data/"$DATASET"/annotations/"$TRAIN_FOLD
COCO_ANN_PATH="./data/"$DATASET"/annotations/"$TRAIN_FOLD"/"$TEST_FOLD"_long-term_anns.json"

TT_TRAIN="./data/"$DATASET"/frames_features/"$TRAIN_FOLD
TT_VAL="./data/"$DATASET"/frames_features/"$TRAIN_FOLD

CHECKPOINT="./model_weights/temporal_consistency_module/"$DATASET"/"$TRAIN_FOLD"/checkpoint_best_phases.pyth"

TYPE="pytorch"

export PYTHONPATH="./must:$PYTHONPATH"

#-------------------------
# Run experiment

mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=1 python -B tools/run_net.py \
--cfg $CONFIG_PATH \
NUM_GPUS 1 \
CHUNKS.CHUNK_SIZE $CHUNK_SIZE \
CHUNKS.OVERLAPPING $OVERLAPPING \
TRAIN.DATASET "Graspchunks" \
TEST.DATASET "Graspchunks" \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
TEST.ENABLE True \
TRAIN.ENABLE False \
TEMPORAL_MODULE.FEATURE_PATH_TRAIN $TT_TRAIN \
TEMPORAL_MODULE.FEATURE_PATH_VAL $TT_VAL \
TEMPORAL_MODULE.ONLINE_INFERENCE False \
TEMPORAL_MODULE.TCM_D_MODEL $S_D_MODEL \
TEMPORAL_MODULE.TCM_CAT_DIM $S_CAT_DIM \
TEMPORAL_MODULE.TCM_NUM_LAYERS $S_LAYERS \
TEMPORAL_MODULE.TCM_NUM_HEADS $S_HEADS \
TEMPORAL_MODULE.TCM_INPUT_DIM $S_INPUT_DIM \
ENDOVIS_DATASET.FRAME_DIR $FRAME_DIR \
ENDOVIS_DATASET.FRAME_LIST_DIR $FRAME_LIST \
ENDOVIS_DATASET.TRAIN_LISTS $TRAIN_FOLD".csv" \
ENDOVIS_DATASET.TEST_LISTS $TEST_FOLD".csv" \
ENDOVIS_DATASET.ANNOTATION_DIR $ANNOT_DIR \
ENDOVIS_DATASET.TEST_COCO_ANNS $COCO_ANN_PATH \
ENDOVIS_DATASET.TRAIN_GT_BOX_JSON "train_long-term_anns.json" \
ENDOVIS_DATASET.TEST_GT_BOX_JSON $TEST_FOLD"_long-term_anns.json" \
TRAIN.BATCH_SIZE 256 \
TEST.BATCH_SIZE 256 \
SOLVER.BASE_LR $LR \
SOLVER.COSINE_END_LR 1e-5 \
SOLVER.WARMUP_START_LR 0.0000125 \
SOLVER.OPTIMIZING_METHOD $OPT \
SOLVER.WARMUP_EPOCHS 5.0 \
SOLVER.MAX_EPOCH 30 \
OUTPUT_DIR $OUTPUT_DIR \


# Experiment setup
TRAIN_FOLD="fold1"
TEST_FOLD="fold2" 
EXP_PREFIX="metric_trial_no_preload"
TASK="PHASES"
ARCH="TCM"

# TCM
S_HEADS=2
S_LAYERS=2
S_CAT_DIM=768
S_D_MODEL=512
S_INPUT_DIM=3072

CHUNK_SIZE=600
OVERLAPPING=500

OPT="adam"
LR=0.0001

DATASET="GraSP"

EXPERIMENT_NAME="$ARCH-chunks_$CHUNK_SIZE-overlap_$OVERLAPPING-dmodel_$S_D_MODEL-catdim_$S_CAT_DIM-layers_$S_LAYERS-heads_$S_HEADS-opt_$OPT-lr_$LR"
CONFIG_PATH="configs/"$DATASET"/"$ARCH"_"$TASK".yaml"
FRAME_DIR="./data/"$DATASET"/frames"
OUTPUT_DIR="outputs/$DATASET/"$TRAIN_FOLD"/"$TASK"/"$EXPERIMENT_NAME
FRAME_LIST="./data/"$DATASET"/frame_lists"
ANNOT_DIR="./data/"$DATASET"/annotations/"$TRAIN_FOLD
COCO_ANN_PATH="./data/"$DATASET"/annotations/"$TRAIN_FOLD"/"$TEST_FOLD"_long-term_anns.json"

TT_TRAIN="./data/"$DATASET"/frames_features/"$TRAIN_FOLD
TT_VAL="./data/"$DATASET"/frames_features/"$TRAIN_FOLD

CHECKPOINT="./model_weights/temporal_consistency_module/"$DATASET"/"$TRAIN_FOLD"/checkpoint_best_phases.pyth"

TYPE="pytorch"

export PYTHONPATH="./must:$PYTHONPATH"

#-------------------------
# Run experiment



mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=1 python -B tools/run_net.py \
--cfg $CONFIG_PATH \
NUM_GPUS 1 \
CHUNKS.CHUNK_SIZE $CHUNK_SIZE \
CHUNKS.OVERLAPPING $OVERLAPPING \
TRAIN.DATASET "Graspchunks" \
TEST.DATASET "Graspchunks" \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
TEST.ENABLE True \
TRAIN.ENABLE False \
TEMPORAL_MODULE.FEATURE_PATH_TRAIN $TT_TRAIN \
TEMPORAL_MODULE.FEATURE_PATH_VAL $TT_VAL \
TEMPORAL_MODULE.ONLINE_INFERENCE False \
TEMPORAL_MODULE.TCM_D_MODEL $S_D_MODEL \
TEMPORAL_MODULE.TCM_CAT_DIM $S_CAT_DIM \
TEMPORAL_MODULE.TCM_NUM_LAYERS $S_LAYERS \
TEMPORAL_MODULE.TCM_NUM_HEADS $S_HEADS \
TEMPORAL_MODULE.TCM_INPUT_DIM $S_INPUT_DIM \
ENDOVIS_DATASET.FRAME_DIR $FRAME_DIR \
ENDOVIS_DATASET.FRAME_LIST_DIR $FRAME_LIST \
ENDOVIS_DATASET.TRAIN_LISTS $TRAIN_FOLD".csv" \
ENDOVIS_DATASET.TEST_LISTS $TEST_FOLD".csv" \
ENDOVIS_DATASET.ANNOTATION_DIR $ANNOT_DIR \
ENDOVIS_DATASET.TEST_COCO_ANNS $COCO_ANN_PATH \
ENDOVIS_DATASET.TRAIN_GT_BOX_JSON "train_long-term_anns.json" \
ENDOVIS_DATASET.TEST_GT_BOX_JSON $TEST_FOLD"_long-term_anns.json" \
TRAIN.BATCH_SIZE 256 \
TEST.BATCH_SIZE 256 \
SOLVER.BASE_LR $LR \
SOLVER.COSINE_END_LR 1e-5 \
SOLVER.WARMUP_START_LR 0.0000125 \
SOLVER.OPTIMIZING_METHOD $OPT \
SOLVER.WARMUP_EPOCHS 5.0 \
SOLVER.MAX_EPOCH 30 \
OUTPUT_DIR $OUTPUT_DIR \

# Experiment setup
TRAIN_FOLD="fold2"
TEST_FOLD="fold1" 
EXP_PREFIX="metric_trial_no_preload"
TASK="PHASES"
ARCH="TCM"

# TCM
S_HEADS=2
S_LAYERS=2
S_CAT_DIM=768
S_D_MODEL=512
S_INPUT_DIM=3072

CHUNK_SIZE=600
OVERLAPPING=500

OPT="adam"
LR=0.0001

DATASET="GraSP"

EXPERIMENT_NAME="$ARCH-chunks_$CHUNK_SIZE-overlap_$OVERLAPPING-dmodel_$S_D_MODEL-catdim_$S_CAT_DIM-layers_$S_LAYERS-heads_$S_HEADS-opt_$OPT-lr_$LR"
CONFIG_PATH="configs/"$DATASET"/"$ARCH"_"$TASK".yaml"
FRAME_DIR="./data/"$DATASET"/frames"
OUTPUT_DIR="outputs/$DATASET/"$TRAIN_FOLD"/"$TASK"/"$EXPERIMENT_NAME
FRAME_LIST="./data/"$DATASET"/frame_lists"
ANNOT_DIR="./data/"$DATASET"/annotations/"$TRAIN_FOLD
COCO_ANN_PATH="./data/"$DATASET"/annotations/"$TRAIN_FOLD"/"$TEST_FOLD"_long-term_anns.json"

TT_TRAIN="./data/"$DATASET"/frames_features/"$TRAIN_FOLD
TT_VAL="./data/"$DATASET"/frames_features/"$TRAIN_FOLD

CHECKPOINT="./model_weights/temporal_consistency_module/"$DATASET"/"$TRAIN_FOLD"/checkpoint_best_phases.pyth"

TYPE="pytorch"

export PYTHONPATH="./must:$PYTHONPATH"

#-------------------------
# Run experiment

mkdir -p $OUTPUT_DIR

CUDA_VISIBLE_DEVICES=1 python -B tools/run_net.py \
--cfg $CONFIG_PATH \
NUM_GPUS 1 \
CHUNKS.CHUNK_SIZE $CHUNK_SIZE \
CHUNKS.OVERLAPPING $OVERLAPPING \
TRAIN.DATASET "Graspchunks" \
TEST.DATASET "Graspchunks" \
TRAIN.CHECKPOINT_FILE_PATH $CHECKPOINT \
TRAIN.CHECKPOINT_EPOCH_RESET True \
TRAIN.CHECKPOINT_TYPE $TYPE \
TEST.ENABLE True \
TRAIN.ENABLE False \
TEMPORAL_MODULE.FEATURE_PATH_TRAIN $TT_TRAIN \
TEMPORAL_MODULE.FEATURE_PATH_VAL $TT_VAL \
TEMPORAL_MODULE.ONLINE_INFERENCE False \
TEMPORAL_MODULE.TCM_D_MODEL $S_D_MODEL \
TEMPORAL_MODULE.TCM_CAT_DIM $S_CAT_DIM \
TEMPORAL_MODULE.TCM_NUM_LAYERS $S_LAYERS \
TEMPORAL_MODULE.TCM_NUM_HEADS $S_HEADS \
TEMPORAL_MODULE.TCM_INPUT_DIM $S_INPUT_DIM \
ENDOVIS_DATASET.FRAME_DIR $FRAME_DIR \
ENDOVIS_DATASET.FRAME_LIST_DIR $FRAME_LIST \
ENDOVIS_DATASET.TRAIN_LISTS $TRAIN_FOLD".csv" \
ENDOVIS_DATASET.TEST_LISTS $TEST_FOLD".csv" \
ENDOVIS_DATASET.ANNOTATION_DIR $ANNOT_DIR \
ENDOVIS_DATASET.TEST_COCO_ANNS $COCO_ANN_PATH \
ENDOVIS_DATASET.TRAIN_GT_BOX_JSON "train_long-term_anns.json" \
ENDOVIS_DATASET.TEST_GT_BOX_JSON $TEST_FOLD"_long-term_anns.json" \
TRAIN.BATCH_SIZE 256 \
TEST.BATCH_SIZE 256 \
SOLVER.BASE_LR $LR \
SOLVER.COSINE_END_LR 1e-5 \
SOLVER.WARMUP_START_LR 0.0000125 \
SOLVER.OPTIMIZING_METHOD $OPT \
SOLVER.WARMUP_EPOCHS 5.0 \
SOLVER.MAX_EPOCH 30 \
OUTPUT_DIR $OUTPUT_DIR \
