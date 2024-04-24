#!/bin/bash
gcc_vrsn=11.3.0
cuda_vrsn=11.8
pyth_vrsn=3.8
module load gcc/12.2.0
export CC=/usr/local/gcc-${gcc_vrsn}/bin/gcc
export CXX=/usr/local/gcc-${gcc_vrsn}/bin/g++
cuda_comp=/usr/local/cuda-${cuda_vrsn}/bin/nvcc
python ./setup.py bdist_wheel -- -DAER_THRUST_BACKEND=CUDA -DCMAKE_CUDA_COMPILER=${cuda_comp}
sudo cp /home/najones/qgpu/q-gpu/_skbuild/linux-x86_64-${pyth_vrsn}/cmake-build/Release/qasm_simulator /usr/local/bin/qasm_simulator
module purge
#export DISABLE_CONAN=1
export CONAN_COMMAND=/home/najones/anaconda3/envs/QiskitDevEnv/bin/conan
cd test
asv run --config asv.linux.conf.json
#cd dist/ && pip uninstall * -y && pip install * && cd ..
