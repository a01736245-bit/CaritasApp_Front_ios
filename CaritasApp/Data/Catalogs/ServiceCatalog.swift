import Foundation

/// Categorías y servicios de la sección Servicios. Las secciones sin párrafos
/// representan información pendiente de confirmar: no se completan con datos supuestos.
enum ServiceCatalog {

    private static let whatToBring = ServiceDetailSection(title: "¿Qué necesitas llevar?")
    private static let whenToGo = ServiceDetailSection(title: "¿Cuándo puedes acudir?")
    private static let whereOffered = ServiceDetailSection(title: "¿Dónde se ofrece?")

    private static func pendingSections() -> [ServiceDetailSection] {
        [
            ServiceDetailSection(title: "¿En qué consiste?"),
            whatToBring,
            whenToGo,
            whereOffered
        ]
    }

    /// Servicio con las cuatro secciones habituales; solo "¿En qué consiste?" lleva contenido.
    private static func basicSections(_ paragraphs: [SectionParagraph]) -> [ServiceDetailSection] {
        [
            ServiceDetailSection(title: "¿En qué consiste?", paragraphs: paragraphs),
            whatToBring,
            whenToGo,
            whereOffered
        ]
    }

    static let categories: [ServiceCategory] = [
        ServiceCategory(
            id: "comida",
            title: "Comida",
            systemImage: "fork.knife",
            services: [
                ServiceItem(
                    id: "recibir_despensa",
                    categoryId: "comida",
                    title: "Recibir una despensa",
                    shortDescription: "Entrega de alimentos básicos para tu familia.",
                    systemImage: "fork.knife",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Entrega de alimentos básicos para tu familia."),
                                SectionParagraph(
                                    label: "¿A quién está dirigido?",
                                    text: "Familias que necesitan apoyo con alimentos."
                                )
                            ]
                        ),
                        whatToBring,
                        whenToGo,
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(label: "Divino Salvador, Chachapa", text: "Reforma sur 104 Col. Centro, Chachapa, Puebla Cp.: 72990"),
                                SectionParagraph(label: "Jesús Buen Pastor", text: "Av. de las Torres s/n. esq. Enrique García Carreto, Manuel Rivera Anaya 72308, Puebla, Pue."),
                                SectionParagraph(label: "La Divina Providencia, Castillotla", text: "Antiguo Camino Real a Castillotla, Lomas de Castillotla, 72490, Puebla, Pue."),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "comer_comedor",
                    categoryId: "comida",
                    title: "Comer en el comedor",
                    shortDescription: "Información pendiente de confirmar.",
                    systemImage: "fork.knife",
                    sections: basicSections([
                        SectionParagraph(text: "Puedes comer en el comedor de un centro de Cáritas."),
                        SectionParagraph(
                            label: "¿A quién está dirigido?",
                            text: "Familias que necesitan apoyo con alimentos."
                        )
                    ])
                )
            ]
        ),
        ServiceCategory(
            id: "salud",
            title: "Salud y medicinas",
            systemImage: "waveform.path.ecg",
            services: [
                ServiceItem(
                    id: "ver_doctor",
                    categoryId: "salud",
                    title: "Ver a un doctor",
                    shortDescription: "Consulta médica general para revisar tu salud y recibir orientación.",
                    systemImage: "waveform.path.ecg",
                    sections: basicSections([
                        SectionParagraph(text: "Consulta médica general para revisar tu salud y recibir orientación."),
                        SectionParagraph(
                            label: "¿A quién está dirigido?",
                            text: "Personas mayores de 18 años que necesitan una consulta médica."
                        )
                    ])
                ),
                ServiceItem(
                    id: "dentista",
                    categoryId: "salud",
                    title: "Dentista",
                    shortDescription: "Revisión y atención dental",
                    systemImage: "waveform.path.ecg",
                    sections: basicSections([
                        SectionParagraph(text: "Revisión y atención dental.")
                    ])
                ),
                ServiceItem(
                    id: "rehabilitacion",
                    categoryId: "salud",
                    title: "Rehabilitación",
                    shortDescription: "Terapia física para recuperación muscular",
                    systemImage: "waveform.path.ecg",
                    sections: basicSections([
                        SectionParagraph(text: "Terapia física para recuperación muscular.")
                    ])
                ),
                ServiceItem(
                    id: "clinica_diagnostico",
                    categoryId: "salud",
                    title: "Clínica de diagnóstico",
                    shortDescription: "Apoyo para realizar estudios",
                    systemImage: "waveform.path.ecg",
                    sections: pendingSections()
                ),
                ServiceItem(
                    id: "dispensario",
                    categoryId: "salud",
                    title: "Dispensario",
                    shortDescription: "Encuentra centros que tienen dispensario.",
                    systemImage: "waveform.path.ecg",
                    sections: pendingSections()
                ),
                ServiceItem(
                    id: "banco_de_medicamentos",
                    categoryId: "salud",
                    title: "Banco de medicamentos",
                    shortDescription: "Busca centros con banco de medicamentos.",
                    systemImage: "waveform.path.ecg",
                    sections: basicSections([
                        SectionParagraph(text: "Información sobre centros que cuentan con banco de medicamentos.")
                    ])
                ),
                ServiceItem(
                    id: "envio_pacientes_clinica_fundacion",
                    categoryId: "salud",
                    title: "Envío de pacientes a Clínica de la Fundación",
                    shortDescription: "Centros que envían pacientes a la Clínica de la Fundación.",
                    systemImage: "waveform.path.ecg",
                    sections: basicSections([
                        SectionParagraph(text: "Algunos centros envían pacientes a la Clínica de la Fundación.")
                    ])
                )
            ]
        ),
        ServiceCategory(
            id: "ropa",
            title: "Ropa",
            systemImage: "tshirt",
            services: [
                ServiceItem(
                    id: "recibir_ropa",
                    categoryId: "ropa",
                    title: "Recibir ropa",
                    shortDescription: "Ropa en buen estado para toda la familia.",
                    systemImage: "tshirt",
                    sections: basicSections([
                        SectionParagraph(text: "Ropa en buen estado para toda la familia."),
                        SectionParagraph(
                            label: "¿A quién está dirigido?",
                            text: "Personas y familias que necesitan ropa."
                        )
                    ])
                ),
                ServiceItem(
                    id: "bazar",
                    categoryId: "ropa",
                    title: "Bazar",
                    shortDescription: "Ropa y otros artículos útiles para ti y tu familia.",
                    systemImage: "tshirt",
                    sections: basicSections([
                        SectionParagraph(text: "Ropa y otros artículos útiles para ti y tu familia.")
                    ])
                )
            ]
        ),
        ServiceCategory(
            id: "apoyo_fisico",
            title: "Apoyo físico",
            systemImage: "figure.roll",
            services: [
                ServiceItem(
                    id: "aparatos_ortopedicos",
                    categoryId: "apoyo_fisico",
                    title: "Aparatos ortopédicos",
                    shortDescription: "Apoyos que ayudan a moverte con mayor facilidad.",
                    systemImage: "figure.roll",
                    sections: basicSections([
                        SectionParagraph(text: "Apoyos que ayudan a moverte con mayor facilidad.")
                    ])
                )
            ]
        ),
        ServiceCategory(id: "desastres", title: "Asistencia a desastres", systemImage: "house"),
        ServiceCategory(id: "migrantes", title: "Auxilio a migrantes", systemImage: "person.2"),
        ServiceCategory(
            id: "talleres",
            title: "Talleres",
            systemImage: "graduationcap",
            services: [
                ServiceItem(
                    id: "cursos_talleres_seminarios",
                    categoryId: "talleres",
                    title: "Cursos, talleres o seminarios",
                    shortDescription: "Actividades para aprender cosas nuevas y compartir con otras personas.",
                    systemImage: "graduationcap",
                    sections: basicSections([
                        SectionParagraph(text: "Actividades para aprender cosas nuevas y compartir con otras personas.")
                    ])
                )
            ]
        ),
        ServiceCategory(
            id: "estancia-infantil",
            title: "Estancia infantil",
            systemImage: "figure.and.child.holdinghands",
            services: [
                ServiceItem(
                    id: "estancia_infantil",
                    categoryId: "estancia-infantil",
                    title: "Estancia infantil",
                    shortDescription: "Un espacio de cuidado para niñas y niños.",
                    systemImage: "figure.and.child.holdinghands",
                    sections: basicSections([
                        SectionParagraph(text: "Un espacio de cuidado para niñas y niños.")
                    ])
                )
            ]
        ),
        // Sin servicios confirmados: la pantalla de categoría muestra su estado vacío.
        ServiceCategory(
            id: "acompanamiento-espiritual",
            title: "Acompañamiento y apoyo espiritual",
            systemImage: "heart.circle"
        )
    ]

    static func findCategory(_ categoryId: String?) -> ServiceCategory? {
        categories.first { $0.id == categoryId }
    }

    static func findService(_ serviceId: String?) -> ServiceItem? {
        categories.flatMap(\.services).first { $0.id == serviceId }
    }
}
