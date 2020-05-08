# Converts bitmap images into dicom files using dcmtk.
# This dataset may be used to test length tool in many different scenarios.

# 1 - No pixel spacing
img2dcm -v -d -i BMP \
  -k 0008,103e="1 - No pixel spacing" \
  -k 0020,0011="1" \
  ./images/image-1.bmp ./dcm/image-1.dcm

# 2 - Pixel Spacing only
img2dcm -v -d -i BMP \
  -k 0008,103e="2 - Pixel Spacing only" \
  -k 0020,0011="2" \
  -k 0028,0030="0.5\0.5" \
  ./images/image-2.bmp ./dcm/image-2.dcm

# 3 - Pixel Spacing (non-squared pixels)
img2dcm -v -d -i BMP \
  -k 0008,103e="3 - Pixel Spacing (non-squared)" \
  -k 0020,0011="3" \
  -k 0028,0030="1.0\0.8" \
  ./images/image-3.bmp ./dcm/image-3.dcm

# 4 - Imager Pixel Spacing only
img2dcm -v -d -i BMP \
  -k 0008,103e="4 - Imager Pixel Spacing only" \
  -k 0018,1164="0.5\0.5" \
  -k 0020,0011="4" \
  ./images/image-4.bmp ./dcm/image-4.dcm

# 5 - Imager Pixel Spacing + Magnification Factor
img2dcm -v -d -i BMP \
  -k 0008,103e="5 - Imager Pixel Spacing + Magnification Factor" \
  -k 0018,1114="1.5" \
  -k 0018,1164="1.35\1.35" \
  -k 0020,0011="5" \
  ./images/image-5.bmp ./dcm/image-5.dcm

# 6 - Magnification Factor + Wrong SID/SOD ratio
img2dcm -v -d -i BMP \
  -k 0008,103e="6 - Magnification Factor + Wrong SID/SOD ratio" \
  -k 0018,1110="1000" \
  -k 0018,1111="500" \
  -k 0018,1114="1.5" \
  -k 0018,1164="1.35\1.35" \
  -k 0020,0011="6" \
  ./images/image-6.bmp ./dcm/image-6.dcm

# 7 - Distance Source to Detector + Distance Source To Patient
img2dcm -v -d -i BMP \
  -k 0008,103e="7 - Dist Source to Detector + Dist Source to Patient" \
  -k 0018,1110="1500" \
  -k 0018,1111="1000" \
  -k 0018,1164="1.35\1.35" \
  -k 0020,0011="7" \
  ./images/image-7.bmp ./dcm/image-7.dcm

# 8 - Distance Source to Detector but Distance Source to Patient equal to 0
img2dcm -v -d -i BMP \
  -k 0008,103e="8 - Distance Source to Patient equal to 0" \
  -k 0018,1110="1500" \
  -k 0018,1111="0" \
  -k 0018,1164="1.20\1.20" \
  -k 0020,0011="8" \
  ./images/image-8.bmp ./dcm/image-8.dcm

# 9 - Pixel Spacing < Imager Pixel Spacing
img2dcm -v -d -i BMP \
  -k 0008,103e="9 - Pixel Spacing < Imager Pixel Spacing" \
  -k 0018,1164="0.8\0.8" \
  -k 0020,0011="9" \
  -k 0028,0030="0.5\0.5" \
  ./images/image-9.bmp ./dcm/image-9.dcm

# 10 - Pixel Spacing = Imager Pixel Spacing
img2dcm -v -d -i BMP \
  -k 0008,103e="10 - Pixel Spacing = Imager Pixel Spacing" \
  -k 0018,1114="1.25" \
  -k 0018,1164="1.0\1.0" \
  -k 0020,0011="10" \
  -k 0028,0030="1.0\1.0" \
  ./images/image-10.bmp ./dcm/image-10.dcm

# 11 - Pixel Spacing Calibration Type
img2dcm -v -d -i BMP \
  -k 0008,103e="11 - Pixel Spacing Calibration Type" \
  -k 0018,1114="1.25" \
  -k 0018,1164="1.0\1.0" \
  -k 0020,0011="10" \
  -k 0028,0030="1.0\1.0" \
  -k 0028,0A02="FIDUCIAL" \
  ./images/image-11.bmp ./dcm/image-11.dcm

# Update all dicom files
dcmodify -nb \
  -i "(0008,0020)=20200501" \
  -i "(0008,0030)=091011.000" \
  -i "(0008,0050)=892349" \
  -i "(0008,0060)=OT" \
  -i "(0008,1030)=Pixel spacing set" \
  -i "(0010,0010)=Spacing^Pixel" \
  -i "(0010,0020)=ps-01" \
  -i "(0020,000d)=1.2.276.0.7230010.3.1.2.2831181057.17205.1588321372.775140" \
  -i "(0020,0010)=PIXSPACING-01" \
  -i "(0020,0013)=1" \
  ./dcm/*.dcm

