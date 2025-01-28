docker build --tag defect-management --file defect-management/Msi.Cad.DefectManagement/Msi.Cad.DefectManagement.Presentation/defectManagement.Dockerfile defect-management/Msi.Cad.DefectManagement
docker tag defect-management:latest europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/defect-management:7.0
docker push europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/defect-management:7.0

docker build --tag parking-management --file parking-management/Msi.Cad.ParkingManagement/Msi.Cad.ParkingManagement.Presentation/parkingManagement.Dockerfile parking-management/Msi.Cad.ParkingManagement
docker tag parking-management:latest europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/parking-management:7.0
docker push europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/parking-management:7.0

docker build --tag parking-garages --file parking-garages/Msi.Cad.ParkingGarages/Msi.Cad.ParkingGarages.Presentation/parkingGarages.Dockerfile parking-garages/Msi.Cad.ParkingGarages
docker tag parking-garages:latest europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/parking-garages:7.0
docker push europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/parking-garages:7.0

docker build --tag facility-management --file facility-management/Msi.Cad.FacilityManagement/Msi.Cad.FacilityManagement.Presentation/facilityManagement.Dockerfile facility-management/Msi.Cad.FacilityManagement
docker tag facility-management:7.0 europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/facility-management:7.0
docker push europe-west1-docker.pkg.dev/festive-almanac-438812-u2/docker-repo/facility-management:7.0