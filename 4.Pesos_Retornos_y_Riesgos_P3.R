#Paquetes Requeridos
library(fBasics)
library(fPortfolio)
library(openxlsx2)
library(PerformanceAnalytics)
library(readxl)
library(timeSeries)

#Data
Data <- data.frame(read_excel("~/Proyecto_3_Portafolio_Eficiente/6.Data_1_P3.xlsx"))
Data$Fecha<- as.Date(Data$Fecha)#Transformando la columna "Fecha", del data frame "Data", a tipo de dato "Date" 

#Retornos
Retornos <- na.omit(Return.calculate(Data), type= "Discrete")

#Transformando Retornos en Serie de Tiempo
RetornosST <- as.timeSeries(Retornos)

#Frontera Eficiente
Frontera_Eficiente <- portfolioFrontier(RetornosST, constraints= "LongOnly")

#Gráfico de Frontera Eficiente 
plot(Frontera_Eficiente, c(1))

#Pesos de Frontera Eficiente
Pesos_FE <- getWeights(Frontera_Eficiente)

#Retornos de Frontera Eficiente
Retornos_FE <- getTargetReturn(Frontera_Eficiente)

#Riesgos de Frontera Eficiente
Riesgos_FE <- getTargetRisk(Frontera_Eficiente)

#Exportar Pesos a Excel
write_xlsx(Pesos_FE, "Pesos.xlsx")

#Exportar Retornos a Excel
write_xlsx(Retornos_FE, "Retornos.xlsx")

#Exportar Riesgos a Excel
write_xlsx(Riesgos_FE, "Riesgos.xlsx")