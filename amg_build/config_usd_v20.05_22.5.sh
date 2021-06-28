#
# Config USD
#
USD_VER="20.05"
RMAN_VER="22.5"

cur_dir=`pwd`
tmp_dir="tmp_usd_v${USD_VER}_rman${RMAN_VER}"

deploy_root="/data/tools"
deploy_dir="${deploy_root}/USD/pixar/USD-v${USD_VER}_rman${RMAN_VER}"

if [ ! -d $tmp_dir ]; then
  mkdir $tmp_dir
fi
mkdir -p $tmp_dir
cd $tmp_dir

#export OpenGL_GL_PREFERENCE=GLVND
#export OpenGL_GL_PREFERENCE=LEGACY#

#export CC=/usr/bin/clang
#export CXX=/usr/bin/clang++

export RENDERMAN_LOCATION="/opt/pixar/RenderManProServer-${RMAN_VER}"

# export BOOST_ROOT="/usr/lib64"
export BOOST_ROOT="${deploy_root}/boost/boost_1_69_0"
export BOOST_LIBRARYDIR="${BOOST_ROOT}/lib"
#export EMBREE_INCLUDE_DIR="/usr/include"
#export EMBREE_LIBRARY="/usr/lib64/libembree3.so"
export MATERIALX_ROOT="${deploy_root}/MaterialX/MaterialX-v1.36.5"
export MATERIALX_STDLIB_DIR="${MATERIALX_ROOT}/libraries/stdlib"
export PTEX_LOCATION="${deploy_root}/wdas/ptex-v4.1.4"
#export OSL_LOCATION="/home/data/tools/OSL/OSL-v1.11.3.0"
export OSL_LOCATION="/usr/lib64"
export OIIO_LOCATION="${deploy_root}/OIIO/OIIO-v2.2.0"
#export OCIO_LOCATION="/home/data/tools/OCIO/OCIO-v2.0.0"
export OCIO_LOCATION="${deploy_root}/OCIO/OCIO-v1.1.1"
export OPENEXR_LOCATION="${deploy_root}/OpenEXR/OpenEXR-v2.4.0"
export OPENSUBDIV_ROOT_DIR="${deploy_root}/OSD/OpenSubdiv-v3.4.0"
export OPENVDB_LOCATION="${deploy_root}/OpenVDB/openvdb-v7.0.0"
export ALEMBIC_DIR="${deploy_root}/alembic/alembic-v1.7.12"

# export TBB_ROOT_DIR="${MAYA_SDK_DIR}"
# export TBB_ROOT_DIR="/home/data/code/LIBS/Autodesk/Maya/Maya2019.1"

#export CXXFLAGS="-std=c++14 -D_GLIBCXX_USE_CXX11_ABI=0"
export CXXFLAGS="-std=c++14"

cmake3 -L -G "Unix Makefiles" \
-DCMAKE_BUILD_TYPE="Release" \
-DCMAKE_INSTALL_PREFIX=${deploy_dir} \
-DOpenGL_GL_PREFERENCE=GLVND \
-DBUILD_SHARED_LIBS=ON \
-DPXR_BUILD_MONOLITHIC=OFF \
-DPXR_STRICT_BUILD_MODE=OFF \
-DPXR_VALIDATE_GENERATED_CODE=OFF \
-DPXR_HEADLESS_TEST_MODE=OFF \
-DPXR_BUILD_TESTS=OFF \
-DPXR_BUILD_EXAMPLES=ON \
-DPXR_BUILD_TUTORIALS=ON \
-DPXR_BUILD_IMAGING=ON \
-DPXR_BUILD_EMBREE_PLUGIN=OFF \
-DPXR_BUILD_OPENIMAGEIO_PLUGIN=ON \
-DPXR_BUILD_OPENCOLORIO_PLUGIN=ON \
-DPXR_BUILD_USD_IMAGING=ON \
-DPXR_BUILD_USDVIEW=ON \
-DPXR_BUILD_ALEMBIC_PLUGIN=ON \
-DPXR_ENABLE_HDF5_SUPPORT=ON \
-DPXR_BUILD_DRACO_PLUGIN=OFF \
-DPXR_BUILD_PRMAN_PLUGIN=ON \
-DPXR_BUILD_MATERIALX_PLUGIN=ON \
-DPXR_BUILD_DOCUMENTATION=OFF \
-DPXR_ENABLE_GL_SUPPORT=ON \
-DPXR_ENABLE_PYTHON_SUPPORT=ON \
-DPXR_USE_PYTHON_3=OFF \
-DPXR_ENABLE_OSL_SUPPORT=ON \
-DPXR_ENABLE_PTEX_SUPPORT=ON \
-DPXR_ENABLE_OPENVDB_SUPPORT=ON \
-DPXR_ENABLE_NAMESPACES=ON \
-DPTEX_LOCATION=${PTEX_LOCATION} \
-DOSL_LOCATION=${OSL_LOCATION} \
-DRENDERMAN_LOCATION=${RENDERMAN_LOCATION} \
-DOPENSUBDIV_ROOT_DIR=${OPENSUBDIV_ROOT_DIR} \
-DALEMBIC_DIR=${ALEMBIC_DIR} \
-DMATERIALX_ROOT=${MATERIALX_ROOT} \
-DMATERIALX_STDLIB_DIR=${MATERIALX_STDLIB_DIR} \
-DOPENVDB_LOCATION=${OPENVDB_LOCATION} \
-DCMAKE_POLICY_DEFAULT_CMP0074=NEW \
-DBoost_NO_BOOST_CMAKE=ON \
../..

#-DPXR_PREFER_SAFETY_OVER_SPEED=ON \
#-DEMBREE_INCLUDE_DIR=${EMBREE_INCLUDE_DIR} \
#-DEMBREE_LIBRARY=${EMBREE_LIBRARY} \
# -DHOUDINI_INCLUDE_DIRS=${HOUDINI_INCLUDE_DIRS} \
# -DHOUDINI_LIB_DIRS=${HOUDINI_LIB_DIRS} \
# -DKATANA_API_LOCATION=${KATANA_API_LOCATION} \
# -DPXR_ENABLE_MULTIVERSE_SUPPORT=OFF \
# -DPXR_BUILD_HOUDINI_PLUGIN=OFF \
# -DPXR_BUILD_KATANA_PLUGIN=ON \
# -DTBB_ROOT_DIR=${TBB_ROOT_DIR} \
#-DMATERIALX_BASE_DIR=${MATERIALX_BASE_DIR} \
#-DCMAKE_CXX_COMPILER_ID="Clang" \
# ``find_package()`` uses ``<PackageName>_ROOT`` variables.
# CMP0074
# -------
# ``find_package()`` uses ``<PackageName>_ROOT`` variables.

if [ $? -eq 0 ]
then
  echo "* "
  echo "* cmake config completed." 
  echo "* run \"make -C ${tmp_dir}\" (or \"make -C ${tmp_dir} install\") " 
  echo "* "
else
  echo "* "
  echo "* cmake config error!"
  echo "* "
fi
