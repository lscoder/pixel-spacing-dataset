# Pixel Spacing Dataset

The dataset contains 10 images that can be used to make sure that distances are calculated correctly by the length tool based on the tag(s) available:
- Pixel Spacing (0028,0030)
- Distance Source to Detector (0018,1110)
- Distance Source to Patient (0018,1111)
- Estimated Radiographic Magnification Factor (0018,1114)
- Imager Pixel Spacing (0018,1164)
- Pixel Spacing Calibration Type (0028,0A02)

Distance Source to Detector and Distance Source to Patient are also referred to as Source Image Receptor Distance (SID) and Source Object Distance (SOD) respectively.

The images were created with [Krita](https://krita.org/), a free image editor available for Windows, Linux and OSX, they were exported to bitmap and DCMTK was used to convert them to DICOM files. The images and the shell script are available on [Github](https://github.com/lscoder/pixel-spacing-dataset)

Each file contains a 512x512px image and each image contains three white squares with different dimensions: 200x200px, 120x120px and 70x70px. Only files with non-squared pixels have different image and square sizes and those are specified below.

In order to get more accurate results it is recommended to disable interpolation and use zoom tool to make micro adjustments which can give you a value very close to the one that is shown inside each square with a difference smaller than 1px or 0.2mm approximately.

## DICOM Files

### image-1.dcm

The viewer must show the measurement in pixels since no tags that specifies the pixel spacing are available.

- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): [not set]
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-2.dcm

In this case Pixel Spacing (0028,0030) tag must be used to convert the distance from pixels to millimeters since it is the only tag available.

<div align="center">distance (mm) = distance (px) * pixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): 0.5/0.5
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): [not set]
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-3.dcm

The size of this image is 640x512px and all three squares have different sizes: 250x200px, 150x120px and 87x70px. Despite everything has different sizes the viewer must show three perfect squares because the pixel aspect ratio is not equal to 1 (non-squared pixels).

<div align="center">distance (mm) = distance (px) * pixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): 1.0/0.8
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): [not set]
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-4.dcm

Only Imager Pixel Spacing is available in this case and it should used with no changes since magnification factor is not set.

<div align="center">distance (mm) = distance (px) * imagerPixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): 0.5/0.5
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-5.dcm

Estimated Radiographic Magnification Factor (0018,1114) is now set to 1.5 and this number is the ratio of Source Image Receptor Distance (SID) over Source Object Distance (SOD). If SID is 1500mm and SOD is 1000mm then the magnification factor will be set to 1.5 which means the final image is 50% bigger than the real object. To find the original size the calculated distance needs to be divided by the magnification factor. For more details, check the [DX Positioning Module](http://dicom.nema.org/medical/dicom/2016e/output/chtml/part03/sect_C.8.11.5.html) documentation.

<div align="center">distance (mm) = distance (px) * imagerPixelSpacing / magnificationFactor</div>

Tags:
- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): 1.5
- Imager Pixel Spacing (0018,1164): 1.35/1.35
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-6.dcm

This file contains inconsistent data on purpose because dividing Distance Source to Detector (0018,1110) by Distance Source to Patient (0018,1111) will give a different value compared to Estimated Radiographic Magnification Factor (0018,1114). Both distances may be ignored once magnification factor is set to a non-zero value.

<div align="center">distance (mm) = distance (px) * imagerPixelSpacing / magnificationFactor</div>

Tags:
- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): 1000
- Distance Source to Patient (0018,1111): 500
- Estimated Radiographic Magnification Factor (0018,1114): 1.5
- Imager Pixel Spacing (0018,1164): 1.35/1.35
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-7.dcm

Both Distance Source to Detector (0018,1110) and Distance Source to Patient (0018,1111) are specified but Estimated Radiographic Magnification Factor (0018,1114) is not. The magnification factor will then be calculated using both distances.

<div align="center">magnificationFactor = distSourceDetector / distSourcePatient</div>
<div align="center"><hr width="150px"></div>
<div align="center">distance (mm) = distance (px) * imagerPixelSpacing / magnificationFactor</div>

Tags:
- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): 1500
- Distance Source to Patient (0018,1111): 1000
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): 1.35/1.35
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-8.dcm

Both Distance Source to Detector (0018,1110) and Distance Source to Patient (0018,1111) are specified but when one of them is set to 0 they must not be used to calculate the magnification factor as done for the previous image. In this case only Imager Pixel Spacing must be used to calculate the distance in millimeters.

<div align="center">distance (mm) = distance (px) * imagerPixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): [not set]
- Distance Source to Detector (0018,1110): 1500
- Distance Source to Patient (0018,1111): 0
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): 1.20/1.20
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-9.dcm

Both Pixel Spacing (0028,0030) and Imager Pixel Spacing (0018,1164) are specified but if the first one is smaller than the second one it must be used to calculate the distance in millimeters. No magnification factor is used in this case even if it is set to a non-zero value.

<div align="center">distance (mm) = distance (px) * pixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): 0.5/0.5
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): [not set]
- Imager Pixel Spacing (0018,1164): 0.8/0.8
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-10.dcm

Both Pixel Spacing (0028,0030) and Imager Pixel Spacing (0018,1164) are specified with the same value and Imager Pixel Spacing (0018,1164) must be used whenever it is smaller than or equal to Pixel Spacing (0028,0030).

<div align="center">distance (mm) = distance (px) * imagerPixelSpacing / magnificationFactor</div>

Tags:
- Pixel Spacing (0028,0030): 1.0/1.0
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): 1.25
- Imager Pixel Spacing (0018,1164): 1.0/1.0
- Pixel Spacing Calibration Type (0028,0A02): [not set]

### image-11.dcm

Both Pixel Spacing (0028,0030) and Imager Pixel Spacing (0018,1164) are specified with the same value but in this case Pixel Spacing Calibration Type (0028,0A02) is set to FIDUCIAL which requires the use of Pixel Spacing (0028,0030).

<div align="center">distance (mm) = distance (px) * pixelSpacing</div>

Tags:
- Pixel Spacing (0028,0030): 1.0/1.0
- Distance Source to Detector (0018,1110): [not set]
- Distance Source to Patient (0018,1111): [not set]
- Estimated Radiographic Magnification Factor (0018,1114): 1.25
- Imager Pixel Spacing (0018,1164): 1.0/1.0
- Pixel Spacing Calibration Type (0028,0A02): FIDUCIAL
