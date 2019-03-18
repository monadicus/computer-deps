%
%  vision.pl
%  computer-deps
%
%  Support for computer vision.
%

meta_pkg('python-vision-recommended', [
    'simplecv',
    'python-zxing'
]).

% python's opencv module
python_pkg(cv2).
installs_with_apt(cv2, 'python-opencv').
depends(cv2, _, [opencv]).

pip_pkg(
    simplecv,
    'SimpleCV',
    'https://github.com/sightmachine/SimpleCV/zipball/develop'
).
depends(simplecv, _, [
    'cv2',
    pygame,
    ipython,
    numpy,
    scipy,
    pil,
    svgwrite
]).

pip_pkg(svgwrite).

% we could use Pillow via pip instead
python_pkg(pil, 'PIL').
installs_with_brew(pil).
installs_with_apt(pil, 'python-imaging').

python_pkg(pygame).
installs_with_apt(pygame, 'python-pygame').
installs_with_brew(pygame).
depends(pygame, osx, [
    smpeg,
    'homebrew-samueljohn-tap'
]).

pkg(smpeg).
met(smpeg, osx) :-
    isfile('/usr/local/lib/libsmpeg.dylib').
meet(smpeg, osx) :-
    bash('brew install --HEAD smpeg').
depends(smpeg, osx, [brew, 'homebrew-headonly-tap']).

brew_tap('homebrew-headonly-tap', 'homebrew/headonly').
brew_tap('homebrew-samueljohn-tap', 'samueljohn/python').

pkg(opencv).
installs_with_apt(opencv, 'libopencv-dev').
installs_with_brew(opencv).
depends(opencv, osx, ['homebrew-science-tap']).

pip_pkg(cython).

pkg(zbar).
installs_with_brew(zbar).
installs_with_apt(zbar, 'libzbar-dev').

% TODO segfault issue
python_pkg('python-zbar', zbar).
meet('python-zbar', osx) :-
    bash('pip install zbar').
meet('python-zbar', linux(_)) :-
    install_apt('python-zbar').
depends('python-zbar', _, [zbar]).

managed_pkg(tesseract).

% TODO meet block
% https://code.google.com/p/python-tesseract/
python_pkg('python-tesseract', tesseract).
depends('python-tesseract', _, [tesseract]).

cwd(Old, New) :- working_directory(Old, New).

% barcode reading with zxing
pkg(zxing).
met(zxing, _) :- isfile('~/.computer/zxing-1.6/javase/javase.jar').
meet(zxing, _) :-
    bash('cd ~/.computer && wget http://zxing.googlecode.com/files/ZXing-1.6.zip'),
    bash('cd ~/.computer && unzip ZXing-1.6.zip && rm ZXing-1.6.zip'),
    bash('cd ~/.computer/zxing-1.6/core && ant build'),
    bash('cd ~/.computer/zxing-1.6/javase && ant build').
depends(zxing, _, [java, ant]).

command_pkg(ant).

pip_pkg('python-zxing', zxing, 'https://github.com/oostendo/python-zxing/zipball/master').
