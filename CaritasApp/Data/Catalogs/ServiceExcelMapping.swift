import Foundation

/// Relación explícita entre cada servicio de CARI Vita y las claves de servicio
/// de los centros (`centers.json`). Nunca se relaciona por coincidencia de nombres.
enum ServiceExcelMapping {

    private static let mapping: [String: [String]] = [
        "recibir_despensa": ["despensas_banco_alimentos", "despensas_parroquia"],
        "comer_comedor": ["comedores_palafox", "comidas_calientes"],
        "ver_doctor": ["consultas_medicas"],
        "dentista": ["consultas_odontologicas"],
        "rehabilitacion": ["fisioterapia"],
        "clinica_diagnostico": ["clinica_de_diagnostico"],
        "cursos_talleres_seminarios": ["cursos_talleres_seminarios"],
        "estancia_infantil": ["estancia_infantil"],
        // Claves confirmadas que todavía no tienen un servicio en el catálogo.
        "visitas_personas_privadas_libertad": ["visitas_personas_privadas_libertad"],
        "servicios_eucaristicos_hospitales": ["servicios_eucaristicos_hospitales"],
        "apoyo_psicologico": ["apoyo_psicologico"],
        "cuidado_integral_de_la_creacion": ["cuidado_integral_de_la_creacion"],
        "dispensario": ["dispensario"],
        "banco_de_medicamentos": ["banco_de_medicamentos"],
        "envio_pacientes_clinica_fundacion": ["envio_pacientes_clinica_fundacion"],
        "bazar": ["bazar"],
        "aparatos_ortopedicos": ["aparatos_ortopedicos"]
    ]

    /// Servicios del catálogo sin una clave confirmada en los datos de centros.
    static let pendingServiceIds: Set<String> = ["recibir_ropa"]

    /// Claves de servicio de los centros que respaldan `serviceId`,
    /// o una lista vacía si no hay relación confirmada.
    static func excelKeys(for serviceId: String) -> [String] {
        mapping[serviceId] ?? []
    }

    static func isMapped(_ serviceId: String) -> Bool {
        mapping[serviceId] != nil
    }
}
