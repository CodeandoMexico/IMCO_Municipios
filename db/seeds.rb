# City.create!([
#   { name: "Chalco" },
#   { name: "Huixquilucan" },
#   { name: "Lerma" },
#   { name: "Metepec" },
#   { name: "Tenango del Valle" },
#   { name: "Toluca" }
#   ])
# Dependency.create!([
#   {nombre: "Centro Municipal de Atencion Empresarial", municipio_id: 1},
#   {nombre: "Externa", municipio_id: 1}
# ])
# Inspection.create!([
#   {nombre: "Notficaciones", materia: "Desarrollo Metropolitano y Economico", duracion: "15 MIN", norma: "Deconformidadconarticulo32delreglamentodelaActividadComercial,IndustrialydeServiciosdelMunicipiodeChalco", antes: "1 identificar el establecimiento*- giro *- motivo de la /verificación/2 tener un historial que respalde dos invitaciones para acudir a la Dirección de Desarrollo Metropolitano y Económico", durante: "1- presentarse ante el titular del negocio portando la credencial que nos identifica como servidores públicos activos/2- dirigirse de manera respetuosa y cortes durante todo el tiempo que dure la notificacion/3- se indica el motivo de la visita y se procede a llenar el acta circunstanciada", despues: "1 Se notifica a la persona que atiende la diligencia cuales son las observaciones finales/2 Se solicita la firma de la persona visitada/3 se despide de manera cortes y se recuerda que tienen que asistir a la Dirección de Desarrollo Metropolitano y Económico que se le elabore su licencia de funcionamiento", sancion: "Procedimiento administrativo de confirmad con el artículo 106  del código de procedimientos administrativos, señala diversos aspectos al usuario, por no cumplir con sus obligaciones municipales, al igual otorgarle su garantía de audiencia lo que a derecho convenga, ", dependency_id: 1},
#   {nombre: "Verificacion", materia: "Desarrollo Metropolitano y Economico", duracion: "15 MIN", norma: "articulo128delcodigodeprocedimientosadministrativos", antes: "1 identificar el establecimiento*- giro *- motivo de la /verificación/2 tener un historial que respalde dos invitaciones para acudir a la Dirección de Desarrollo Metropolitano y Económico", durante: "1- presentarse ante el titular del negocio portando la credencial que nos identifica como servidores públicos activos/2- dirigirse de manera respetuosa y cortes durante todo el tiempo que dure la notificacion/3- se indica el motivo de la visita y se procede a llenar el acta circunstanciada", despues: "1 Se notifica a la persona que atiende la diligencia cuales son las observaciones finales/2 Se solicita la firma de la persona visitada/3 se despide de manera cortes y se recuerda que tienen que asistir a la Dirección de Desarrollo Metropolitano y Económico que se le elabore su licencia de funcionamiento", sancion: "Procedimiento administrativo de confirmad con el artículo 106  del código de procedimientos administrativos, señala diversos aspectos al usuario, por no cumplir con sus obligaciones municipales, al igual otorgarle su garantía de audiencia lo que a derecho convenga, ", dependency_id: 1}
# ])
# Inspector.create!([
#   {nombre: "Bertha Camerina Alvarez Bautista", vigencia: "2013-2015", materia: "Desarrollo Metropolitano y Economico", supervisor: "Monica Guadalupe Poblano Gil", contacto: "Calle Santiago No. 6 1er piso Tel:59733565", foto: "fotos\\Bertha Camerina Alvarez Bautista.jpg", dependency_id: 1},
#   {nombre: "Corrales Lopez Israel", vigencia: "2013-2015", materia: "Desarrollo Metropolitano y Economico", supervisor: "Monica Guadalupe Poblano Gil", contacto: "Calle Santiago No. 6 1er piso Tel:59733565", foto: "fotos\\Corrales Lopez Israel.jpg", dependency_id: 1}
# ])
# Line.create!([
#   {nombre: "ARTICULOS MAGNETOFONICOS Y MUSICALES", descripcion: "venta de equipos y aditamentos", municipio_id: 1},
#   {nombre: "ABARROTES AL POR MENOR (TIENDITAS MISCELANEAS)", descripcion: "Abarrotes", municipio_id: 1},
#   {nombre: "ACUARIO", descripcion: "venta de peces y aditamentos", municipio_id: 1},
#   {nombre: "AGENCIA DE TELEFONIA CELULAR", descripcion: "venta de equipos y aditamentos", municipio_id: 1},
#   {nombre: "ALIMENTO PARA GANADO Y AVES", descripcion: "venta de alimentos", municipio_id: 1}
# ])
# Procedure.create!([
#   {nombre: "Procedimiento para la Expedición de Licencias de Funcionamiento(ALTAS) (persona moral)", duracion: "3 diasHabiles", costo: "511pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento (REVALIDACIONES)(persona moral)", duracion: "3 dias Habiles", costo: "511pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento(REANUDACION DE ACTIVIDADES) (persona moral)", duracion: "3 dias Habiles", costo: "511 pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento(SUSPENSIàN DE ACTIVIDADES TEMPORALES) (persona moral)", duracion: "3 dias Habiles", costo: "511 pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento(BAJA) (persona moral)", duracion: "3 dias Habiles", costo: "511pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento(CAMBIO DE DOMICILIO)(persona moral)", duracion: "3 dias Habiles", costo: "511pesos", vigencia: "1 año fiscal", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TM"},
#   {nombre: "Procedimiento para la Expedici¢n de Licencias de Funcionamiento(ALTAS) (persona fisica)", duracion: "3 dias Habiles", costo: "511pesos", vigencia: "3 años", contacto: "Calle Santiago No.6 1er piso Tel: 59733565", dependency_id: 1, tipo: "TF"}
# ])
# ProcedureLine.create!([
#   {procedure_id: 1, line_id: 1},
#   {procedure_id: 2, line_id: 1},
#   {procedure_id: 3, line_id: 1},
#   {procedure_id: 4, line_id: 1},
#   {procedure_id: 5, line_id: 1},
#   {procedure_id: 6, line_id: 1},
#   {procedure_id: 1, line_id: 2},
#   {procedure_id: 4, line_id: 2},
#   {procedure_id: 18, line_id: 1}
# ])
# Requirement.create!([
#   {nombre: "Solicitud (proporcionada por la Dirección)", descripcion: "copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Poder notarial (con identificaci¢n oficial del apoderado/a legal) ", descripcion: "copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Acta constitutiva", descripcion: "copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Licencia de uso de suelo", descripcion: "copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Comprobante de domicilio", descripcion: "copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Croquis de localización", descripcion: "impreso", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "N"},
#   {nombre: "Inscripción al RFC", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AF"},
#   {nombre: "Registro de la Empresa IMSS, persona física", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AF"},
#   {nombre: "Licencia COFEPRIS", descripcion: "En caso de que se vaya a vender cigarros debes contemplarlo", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AF"},
#   {nombre: "Padrón de importadores", descripcion: "En caso de que se vaya a vender cigarros debes contemplarlo", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AF"},
#   {nombre: "Constitución de sociedades ante la SE", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Aviso de uso de los permisos para la constitución de sociedades", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Registro público de la propiedad y el comercio", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Inscripción al RFC", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Registro de la Empresa IMSS, persona moral", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Licencia COFEPRIS", descripcion: "En caso de que se vaya a vender cigarros debes contemplarlo", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"},
#   {nombre: "Padrón de importadores", descripcion: "Alta del documento, se debe contar con copia", path: "http://www.ine.mx/archivos2/portal/credencial/realizarTramite.html", tipo: "AM"}
#   ])
# ProcedureRequirement.create!([
#   {procedure_id: 1, requirement_id: 1},
#   {procedure_id: 1, requirement_id: 2},
#   {procedure_id: 1, requirement_id: 3},
#   {procedure_id: 1, requirement_id: 4},
#   {procedure_id: 1, requirement_id: 5},
#   {procedure_id: 1, requirement_id: 6},
#   {procedure_id: 2, requirement_id: 1},
#   {procedure_id: 2, requirement_id: 2},
#   {procedure_id: 2, requirement_id: 3},
#   {procedure_id: 4, requirement_id: 1},
#   {procedure_id: 18, requirement_id: 2}
# ])
