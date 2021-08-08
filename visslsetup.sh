#!/bin/sh
cd ~
echo "[visslsetup]:script version:0.1.2"
echo "[visslsetup]:ADVICE:Create a new environment to excute this script"
echo "[visslsetup]:Confirm that <opencv> and <pytorch> are installed"
echo -n "[visslsetup]:The script will install <apex>,<vissl> in this environment,continue[y/n]? "
read input
control="y"
if [ $input == $control ]
then
        set -e
        echo "[visslsetup]:check...."
        python -c 'import torch,cv2'
        set +e
	echo "[visslsetup]:copy apex from source..."
        set -e
	git clone --recursive https://www.github.com/NVIDIA/apex
        set +e
        echo "[visslsetup]:done!"
        echo "[visslsetup]:copy vissl from source"
        set -e
        git clone --recursive https://github.com/facebookresearch/vissl.git
        set +e
        echo "[visslsetup]:install apex..."
        set -e
	cd apex
	python3 setup.py install
        python -c 'import apex'
        set +e
        echo "[visslsetup]:done!"
	echo "[visslsetup]:install vissl..."
        set -e
	cd
        cd vissl
        pip install --progress-bar off -r requirements.txt
        python -c 'import vissl'
        set +e
        echo "[visslsetup]:done!"
        set +e
        echo "[visslsetup]:install classy-vision..."
        set -e
        pip install classy-vision@https://github.com/facebookresearch/ClassyVision/tarball/master
        set +e
        echo "[visslsetup]:done!"
	echo "[visslsetup]:complete soon..."
	pip install -e .[dev]
        echo "[visslsetup]:now, you can use vissl!"
else
	exit
fi
