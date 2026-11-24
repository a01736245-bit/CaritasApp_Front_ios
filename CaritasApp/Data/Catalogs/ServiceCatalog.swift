import Foundation

/// Categorías y servicios de la sección Servicios. Las secciones sin párrafos
/// representan información pendiente de confirmar: no se completan con datos supuestos.
enum ServiceCatalog {

    private static func pendingSections() -> [ServiceDetailSection] {
        [
            ServiceDetailSection(title: "¿En qué consiste?"),
            ServiceDetailSection(title: "¿Qué necesitas llevar?"),
            ServiceDetailSection(title: "¿Cuándo puedes acudir?"),
            ServiceDetailSection(title: "¿Dónde se ofrece?")
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
                                SectionParagraph(label: "¿A quién está dirigido?", text: "Familias que necesitan apoyo con alimentos.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Divino Salvador, Chachapa",
                                    text: "Reforma sur 104 Col. Centro, Chachapa, Puebla Cp.: 72990"
                                ),
                                SectionParagraph(
                                    label: "Jesús Buen Pastor",
                                    text: "Av. de las Torres s/n. esq. Enrique García Carreto, Manuel Rivera Anaya 72308, Puebla, Pue."
                                ),
                                SectionParagraph(
                                    label: "La Divina Providencia, Castillotla",
                                    text: "Antiguo Camino Real a Castillotla, Lomas de Castillotla, 72490, Puebla, Pue."
                                ),
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
                    shortDescription: "Encuentras el servicio de disfrutar de una buena comida caliente",
                    systemImage: "fork.knife",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Puedes comer en el comedor de un centro de Cáritas."),
                                SectionParagraph(label: "¿A quién está dirigido?", text: "Familias que necesitan apoyo con alimentos.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "Primer contacto con Comedores Palafox",
                            paragraphs: [
                                SectionParagraph(label: "Red de Comedores Palafox", text: "9 Oriente No. 3 Altos, Centro Histórico, Puebla, Pue."),
                                SectionParagraph(label: "Horario de atención", text: "Lunes a viernes de 13:30 a 14:50 horas."),
                                SectionParagraph(text: "Los siguientes pasos dependen del resultado de este primer contacto.")
                            ],
                            contactPhone: "222 190 38 84"
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(label: "San Francisco de Asís, Chietla", text: "Jiménez 7 Centro, 74580, Chietla, Pue."),
                                SectionParagraph(
                                    label: "Jesús Buen Pastor",
                                    text: "Av. de las Torres s/n. esq. Enrique García Carreto, Manuel Rivera Anaya 72308, Puebla, Pue."
                                ),
                                SectionParagraph(
                                    label: "Nuestra Señora de Guadalupe",
                                    text: "21 poniente esquina Zaragoza Col. Guadalupe Victoria, Atlixco Cp. 74280."
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Consulta médica general para revisar tu salud y recibir orientación."),
                                SectionParagraph(
                                    label: "¿A quién está dirigido?",
                                    text: "Personas mayores de 18 años que necesitan una consulta médica."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Jerónimo, Aljojuca",
                                    text: "Av. Independencia No. 4, Tercera Sección, 75180, Aliojuca, Pue."
                                ),
                                SectionParagraph(
                                    label: "San Juan Evangelista, Acatzingo",
                                    text: "16 de Septiembre 205, Col. Centro, Acatzingo, Puebla, 75150"
                                ),
                                SectionParagraph(label: "San Matías Apóstol", text: "Pt. Hidalgo 10 Centro, 74110, San Matías Tlalancaleca, Pue."),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "dentista",
                    categoryId: "salud",
                    title: "Dentista",
                    shortDescription: "Revisión y atención dental",
                    systemImage: "waveform.path.ecg",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Revisión y atención dental.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Jesús Buen Pastor",
                                    text: "Av. de las Torres s/n. esq. Enrique García Carreto, Manuel Rivera Anaya 72308, Puebla, Pue."
                                ),
                                SectionParagraph(
                                    label: "San Andrés Apóstol, Hueyapan",
                                    text: "Calle Ocampo No. 1 Col. Centro Hueyapan, Pue. Cp.: 73920"
                                ),
                                SectionParagraph(label: "San Juan Bautista, Libres", text: "Constitución No. 3, Centro, 73780, Libres, Pue."),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "rehabilitacion",
                    categoryId: "salud",
                    title: "Rehabilitación",
                    shortDescription: "Terapia física para recuperación muscular",
                    systemImage: "waveform.path.ecg",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Terapia física para recuperación muscular.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(label: "San Juan Bautista, Libres", text: "Constitución No. 3, Centro, 73780, Libres, Pue."),
                                SectionParagraph(
                                    label: "San Rafael Arcángel, Tlanalapan",
                                    text: "Av. Nacional esq. 5 de mayo, San Rafael, Tlanalapan, Puebla"
                                ),
                                SectionParagraph(
                                    label: "Santa María de la Asunción, Tlancualpican",
                                    text: "Leona Vicario # 1 Col. Centro, Tlancualpicán Cp.: 74735"
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?"
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Rafael Arcángel, Tlanalapan",
                                    text: "Av. Nacional esq. 5 de mayo, San Rafael, Tlanalapan, Puebla"
                                ),
                                SectionParagraph(label: "San Isidro Labrador, Granjas de San Isidro", text: "14 Sur S/N, Col. San Isidro, Cp. 72590"),
                                SectionParagraph(
                                    label: "San Marcos Evangelista, Grajales",
                                    text: "Emilio Carranza # 6 (Casa Parroquial 3 sur # 6) Col. Centro, Rafael Lara Grajales Cp.: 75000"
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "banco_de_medicamentos",
                    categoryId: "salud",
                    title: "Banco de medicamentos",
                    shortDescription: "Busca centros con banco de medicamentos.",
                    systemImage: "waveform.path.ecg",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Información sobre centros que cuentan con banco de medicamentos.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Baltazar, Campeche",
                                    text: "Calle Cué Merlo # 204 Col. San Baltazar Campeche, Puebla, Pue., Cp. 72550"
                                ),
                                SectionParagraph(label: "San Miguel Arcángel", text: "Plazuela Benito Juárez #19, San Miguel Xoxtla, Puebla, 72620"),
                                SectionParagraph(label: "San Pedro Cholula", text: "5 de mayo # 401 Col. Centro, San Pedro Cholula Cp.: 72760"),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "envio_pacientes_clinica_fundacion",
                    categoryId: "salud",
                    title: "Envío de pacientes a Clínica de la Fundación",
                    shortDescription: "Centros que envían pacientes a la Clínica de la Fundación.",
                    systemImage: "waveform.path.ecg",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Algunos centros envían pacientes a la Clínica de la Fundación.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Luís Guanella",
                                    text: "Religiosos Padres Guanelianos, Calle Maximino Ávila Camacho No. 76, Col. La Preciosa Sangre, Capulac, Amozoc, Cp.: 72920"
                                ),
                                SectionParagraph(
                                    label: "Santa María de la Natividad, Nauzontla",
                                    text: "Calle Francisco I Madero No. 39, Col. Centro, Nauzontla   Cp.: 73550"
                                ),
                                SectionParagraph(
                                    label: "Nuestra Señora de Guadalupe, Xaltipan",
                                    text: "Calle Antonio Julián Zapata, Esquina con Calle Guadalupana., 73972"
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Ropa en buen estado para toda la familia."),
                                SectionParagraph(label: "¿A quién está dirigido?", text: "Personas y familias que necesitan ropa.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(text: "Llama a la parroquia para consultar los requisitos antes de acudir.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "En San Marcos Evangelista, Grajales, se registra una entrega de ropa cada dos meses en la Junta Auxiliar. Llama a la parroquia para confirmar la próxima fecha y el horario."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Marcos Evangelista, Grajales",
                                    text: "La entrega se realiza en la Junta Auxiliar. Comunícate con la parroquia para confirmar la ubicación exacta."
                                ),
                                SectionParagraph(text: "Toca «Ver lugares» para consultar el teléfono y los datos de la parroquia.")
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "bazar",
                    categoryId: "ropa",
                    title: "Bazar",
                    shortDescription: "Ropa y otros artículos útiles para ti y tu familia.",
                    systemImage: "tshirt",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Ropa y otros artículos útiles para ti y tu familia.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(label: "San Matías Apóstol", text: "Pt. Hidalgo 10 Centro, 74110, San Matías Tlalancaleca, Pue."),
                                SectionParagraph(label: "San Francisco de Asís, Chietla", text: "Jiménez 7 Centro, 74580, Chietla, Pue."),
                                SectionParagraph(
                                    label: "Santa María de la Asunción, Tlatlauquitepec",
                                    text: "Av. Reforma 80, Centro, 73900 Tlatlauquitepec, Pue."
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Apoyos que ayudan a moverte con mayor facilidad.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Divino Salvador, Chachapa",
                                    text: "Reforma sur 104 Col. Centro, Chachapa, Puebla Cp.: 72990"
                                ),
                                SectionParagraph(label: "María Reina", text: "Río Bravo # 5730 Col. Jardines de San Manuel, Puebla. Pue. CP.: 72570"),
                                SectionParagraph(
                                    label: "Nuestra Señora de Guadalupe",
                                    text: "21 poniente esquina Zaragoza Col. Guadalupe Victoria, Atlixco Cp. 74280"
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        ServiceCategory(
            id: "desastres",
            title: "Asistencia a desastres",
            systemImage: "house",
            services: [
                ServiceItem(
                    id: "asistencia_en_desastres",
                    categoryId: "desastres",
                    title: "Asistencia a desastres",
                    shortDescription: "Orientación y apoyo para personas afectadas por un desastre.",
                    systemImage: "house",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Consulta los apoyos disponibles para personas y familias afectadas por un desastre.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Luís Guanella",
                                    text: "Religiosos Padres Guanelianos, Calle Maximino Ávila Camacho No. 76, Col. La Preciosa Sangre, Capulac, Amozoc, Cp.: 72920"
                                ),
                                SectionParagraph(
                                    label: "Nuestra Señora de Guadalupe, Xaltipan",
                                    text: "Calle Antonio Julián Zapata, Esquina con Calle Guadalupana., 73972"
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Actividades para aprender cosas nuevas y compartir con otras personas.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Divino Salvador, Chachapa",
                                    text: "Reforma sur 104 Col. Centro, Chachapa, Puebla Cp.: 72990"
                                ),
                                SectionParagraph(
                                    label: "San Andrés Apóstol, Hueyapan",
                                    text: "Calle Ocampo No. 1 Col. Centro Hueyapan, Pue. Cp.: 73920"
                                ),
                                SectionParagraph(
                                    label: "San Jerónimo, Aljojuca",
                                    text: "Av. Independencia No. 4, Tercera Sección, 75180, Aliojuca, Pue."
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
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
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Un espacio de cuidado para niñas y niños.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los centros y los horarios de este servicio. Si no aparece el horario de un centro, llama al teléfono indicado para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Jerónimo, Aljojuca",
                                    text: "Av. Independencia No. 4, Tercera Sección, 75180, Aliojuca, Pue."
                                ),
                                SectionParagraph(
                                    text: "Para ver más lugares donde se ofrece este servicio, toca «Ver lugares».",
                                    isHighlighted: true
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        ServiceCategory(
            id: "acompanamiento-espiritual",
            title: "Acompañamiento y apoyo espiritual",
            systemImage: "heart.circle",
            services: [
                ServiceItem(
                    id: "apoyo_psicologico",
                    categoryId: "acompanamiento-espiritual",
                    title: "Apoyo psicológico",
                    shortDescription: "Encuentra parroquias que ofrecen apoyo psicológico.",
                    systemImage: "heart.circle",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(text: "Apoyo psicológico. Comunícate con la parroquia para conocer la atención disponible.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Todos los servicios solicitan un donativo simbólico. En casos extraordinarios, si no puedes darlo, recibirás la atención sin cobro."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los horarios disponibles de este servicio en cada parroquia. Si no aparece un horario, llama para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Divino Salvador, Chachapa",
                                    text: "Reforma sur 104 Col. Centro, Chachapa, Puebla Cp.: 72990"
                                ),
                                SectionParagraph(
                                    label: "San Jerónimo, Aljojuca",
                                    text: "Av. Independencia No. 4, Tercera Sección, 75180, Aliojuca, Pue."
                                ),
                                SectionParagraph(label: "San Juan Bautista, Libres", text: "Constitución No. 3, Centro, 73780, Libres, Pue."),
                                SectionParagraph(text: "Toca «Ver lugares» para encontrar las parroquias que ofrecen apoyo psicológico.")
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "cuidado_integral_de_la_creacion",
                    categoryId: "acompanamiento-espiritual",
                    title: "Cuidado integral de la creación",
                    shortDescription: "Actividades para cuidar el medio ambiente.",
                    systemImage: "heart.circle",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Actividades relacionadas con el cuidado del medio ambiente. Llama a la parroquia para conocer cuáles se realizan."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(text: "Llama a la parroquia para consultar los requisitos y materiales de la actividad.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los horarios disponibles de este servicio en cada parroquia. Si no aparece un horario, llama para consultarlo."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Jesús Buen Pastor",
                                    text: "Av. de las Torres s/n. esq. Enrique García Carreto, Manuel Rivera Anaya 72308, Puebla, Pue."
                                ),
                                SectionParagraph(
                                    label: "Santa María de la Natividad, Nauzontla",
                                    text: "Calle Francisco I Madero No. 39, Col. Centro, Nauzontla   Cp.: 73550"
                                ),
                                SectionParagraph(text: "Toca «Ver lugares» para encontrar las parroquias que ofrecen este servicio.")
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "servicios_eucaristicos_hospitales",
                    categoryId: "acompanamiento-espiritual",
                    title: "Servicios eucarísticos",
                    shortDescription: "Atención espiritual en hospitales y sanatorios.",
                    systemImage: "heart.circle",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Servicios eucarísticos en hospitales y sanatorios. Llama a la parroquia para consultar la atención disponible y cómo solicitarla."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(text: "Comunícate con la parroquia para consultar los requisitos y coordinar la atención.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los días y horarios registrados en cada parroquia. Llama para coordinar la atención antes de acudir."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Andrés Apóstol, Hueyapan",
                                    text: "Calle Ocampo No. 1 Col. Centro Hueyapan, Pue. Cp.: 73920"
                                ),
                                SectionParagraph(label: "San Pedro Cholula", text: "5 de mayo # 401 Col. Centro, San Pedro Cholula Cp.: 72760"),
                                SectionParagraph(text: "Toca «Ver lugares» para encontrar las parroquias que ofrecen este servicio.")
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "visitas_personas_privadas_libertad",
                    categoryId: "acompanamiento-espiritual",
                    title: "Visitas a personas privadas de su libertad",
                    shortDescription: "Consulta las visitas y el acompañamiento disponibles.",
                    systemImage: "heart.circle",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Visitas a personas privadas de su libertad. Comunícate con la parroquia para conocer en qué consiste el apoyo y cómo se organiza."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(text: "Llama a la parroquia para consultar los requisitos y las condiciones de las visitas.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los días y horarios registrados en cada parroquia. Llama para confirmar las fechas y coordinar la visita."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "San Luís Guanella",
                                    text: "Religiosos Padres Guanelianos, Calle Maximino Ávila Camacho No. 76, Col. La Preciosa Sangre, Capulac, Amozoc, Cp.: 72920"
                                ),
                                SectionParagraph(label: "San Juan Bautista, Libres", text: "Constitución No. 3, Centro, 73780, Libres, Pue."),
                                SectionParagraph(text: "Toca «Ver lugares» para encontrar las parroquias que organizan este servicio.")
                            ]
                        )
                    ]
                ),
                ServiceItem(
                    id: "auxilio_migrantes_y_peregrinos",
                    categoryId: "acompanamiento-espiritual",
                    title: "Auxilio a migrantes y peregrinos",
                    shortDescription: "Consulta los apoyos disponibles para migrantes y peregrinos.",
                    systemImage: "heart.circle",
                    sections: [
                        ServiceDetailSection(
                            title: "¿En qué consiste?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Apoyo a personas migrantes y peregrinas. Llama a la parroquia para conocer los apoyos disponibles."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Qué necesitas llevar?",
                            paragraphs: [
                                SectionParagraph(text: "Comunícate con la parroquia para consultar los requisitos antes de acudir.")
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Cuándo puedes acudir?",
                            paragraphs: [
                                SectionParagraph(
                                    text: "Toca «Ver lugares» para consultar los días y horarios registrados de este servicio en cada parroquia. Llama para confirmar la disponibilidad antes de acudir."
                                )
                            ]
                        ),
                        ServiceDetailSection(
                            title: "¿Dónde se ofrece?",
                            paragraphs: [
                                SectionParagraph(
                                    label: "Nuestra Señora de Guadalupe",
                                    text: "21 poniente esquina Zaragoza Col. Guadalupe Victoria, Atlixco Cp. 74280"
                                ),
                                SectionParagraph(
                                    label: "San Andrés Apóstol, Hueyapan",
                                    text: "Calle Ocampo No. 1 Col. Centro Hueyapan, Pue. Cp.: 73920"
                                ),
                                SectionParagraph(text: "Toca «Ver lugares» para encontrar las parroquias que ofrecen este apoyo.")
                            ]
                        )
                    ]
                )
            ]
        )
    ]

    static func findCategory(_ categoryId: String?) -> ServiceCategory? {
        categories.first { $0.id == categoryId }
    }

    static func findService(_ serviceId: String?) -> ServiceItem? {
        categories.flatMap(\.services).first { $0.id == serviceId }
    }
}
