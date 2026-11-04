import Foundation

/// Servicio registrado en los datos de centros. `key` es el identificador estable
/// que aparece en `Center.services`; `label` es el texto de origen, sin corregir.
struct ExcelService {
    let key: String
    let label: String
}

enum ExcelServiceCatalog {

    static let all: [ExcelService] = [
        ExcelService(key: "aparatos_ortopedicos", label: "Aparatos ortopédicos"),
        ExcelService(key: "apoyo_psicologico", label: "Apoyo Psicológico Y"),
        ExcelService(key: "asistencia_en_desastres", label: "Asistencia en Desastres"),
        ExcelService(key: "auxilio_migrantes_y_peregrinos", label: "Auxilio Migrantes y Peregrinos"),
        ExcelService(key: "banco_de_medicamentos", label: "Banco de Medicamen-tos"),
        ExcelService(key: "bazar", label: "Bazar"),
        ExcelService(key: "clinica_de_diagnostico", label: "Clínica de Diagnóstico"),
        ExcelService(key: "comedores_palafox", label: "Comedores Palafox"),
        ExcelService(key: "comidas_calientes", label: "Comidas Calientes"),
        ExcelService(key: "consultas_medicas", label: "Consultas Médicas"),
        ExcelService(key: "consultas_odontologicas", label: "Consultas Odontológi-cas"),
        ExcelService(key: "cuidado_integral_de_la_creacion", label: "Cuidado Integral de la Creación"),
        ExcelService(key: "cursos_talleres_seminarios", label: "Cursos, Talleres o Seminarios"),
        ExcelService(key: "despensas_banco_alimentos", label: "Despensas dadas por Banco de Alimentos"),
        ExcelService(key: "despensas_parroquia", label: "Despensas dadas por la Parroquia"),
        ExcelService(key: "dispensario", label: "Dispensario"),
        ExcelService(key: "envio_pacientes_clinica_fundacion", label: "Envío de pacientes a Clínica de la Fundación"),
        ExcelService(key: "estancia_infantil", label: "Estancia Infantil"),
        ExcelService(key: "fisioterapia", label: "Fisioterapia"),
        ExcelService(key: "otros_beneficios", label: "Otros Beneficios"),
        ExcelService(key: "servicios_eucaristicos_hospitales", label: "Servicios Eucarísticos Hospitales, Sanatorios…"),
        ExcelService(key: "visitas_personas_privadas_libertad", label: "Visitas a personas privadas de su libertad")
    ]

    private static let labelsByKey: [String: String] = Dictionary(
        uniqueKeysWithValues: all.map { ($0.key, $0.label) }
    )

    /// Etiqueta de origen de una clave, o la propia clave si no está en el catálogo.
    static func labelFor(_ key: String) -> String {
        labelsByKey[key] ?? key
    }
}
