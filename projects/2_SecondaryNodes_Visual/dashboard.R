# Carga la librería Shiny

library(shiny)
library(shinyWidgets)

# Define la interfaz de usuario
ui <- fluidPage(
  # Configuración de la apariencia
  tags$head(
    tags$style(HTML("
      body {
        background-color: #1f1f1f; 
        color: #fff;
        min-width: 800px; /* Establece el ancho mínimo de toda la aplicación */
      }
      .left-panel {
        background-color: #2b2b2b; 
        padding: 20px; 
        width: 190px; /* Establece un ancho fijo para el panel izquierdo */
        min-width: 190px; /* Asegura que panel izquierdo no sea más pequeño */
        max-width: 190px; /* Asegura que panel izquierdo no sea más grande */
        float: left; /* Mantiene el panel a la izquierda */
        height: 100vh; /* Hace que el panel ocupe toda la altura de ventana */
        overflow-y: auto; /* Añade scroll si contenido es mayor que altura */
      }
      .right-panel {
        background-color: #3a3a3a; 
        padding: 20px;
        margin-left: 200px; /* Mueve right-panel a la derecha del left-panel */
        height: 100vh; /* Hace que panel ocupe toda la altura de la ventana */
        overflow-y: auto; /* Añade scroll si contenido es mayor que altura */
        min-width: 500px; /* Establece un ancho mínimo para el right-panel */
        display: flex;
        flex-direction: column;
      }
      .titulo {
        font-size: 18px; 
        font-weight: bold; 
        margin-bottom: 5px; /* Reduce espacio inferior para acercar elementos */
      }
      /* NUEVO ESTILO INSERTADO AQUÍ - EN LA SECCIÓN DE TÍTULOS */
      .subtitulo {
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 5px;
        color: #a0a0a0;
      }
      .btn-custom {
        width: 100%; /* Hace que botones ocupen el 100% del ancho disponible */
        margin-top: 0px; /* Reduce espacio superior cerca de pickerInput */
        margin-bottom: 10px; /* Añade un margen inferior uniforme */
      }
      .picker-custom {
        width: 100%; /* Hace que pickerInput ocupen 100% del ancho disponible */
        margin-bottom: 0px; /* Reduce espacio inferior para acercar el botón */
      }
      .group {
        margin-bottom: 10px; /* Añade espacio entre los grupos */
      }
      #canvas {
        flex-grow: 1;
        min-width: 300px; /* Establece un ancho mínimo para el canvas */
        height: 100%; /* Ocupa toda la altura disponible en el right-panel */
        overflow-y: auto; /* Añade scroll vertical para desborde de contenido */
      }
      .refresh-btn {
        /* width: 100%; /* Ocupa todo el ancho disponible */
        /* position: absolute; */
        /* top: 10px; */
        /* right: 10px; */
        /* z-index: 1000; */
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 8px 16px;
        cursor: pointer;
        margin-bottom: 10px; /* Mantiene consistencia con otros botones
      }
      .refresh-btn:hover {
        background-color: #45a049;
      }
    "))
  ),
    
  fluidRow(
    div(class = "left-panel",
      div(class = "group",
        div(class = "titulo", "DASHBOARD"),
        div(class = "subtitulo", "order by..."),  # NUEVO TÍTULO AQUÍ
        pickerInput("combo2", label = NULL,
                    choices = c("BTP", "STATUS", "RELEASE DATE", "NUMBER CRC", "TEAM"),
                    options = list(style = "btn-info picker-custom")),
        div(class = "subtitulo", "filter by..."),  
        # Añadimos el checkbox_dropdown debajo de combo2
        pickerInput(
          inputId = "checkbox_dropdown_1",
          label = NULL,
          choices = c("26/10/2022", "25/10/2023", "19/12/2023",
                      "29/05/2024", "25/09/2024", "19/10/2024","29/10/2024","27/11/2024",
                      "27/05/2025"),
          multiple = TRUE,
          selected = c("26/10/2022", "25/10/2023", "19/12/2023",
                       "29/05/2024", "25/09/2024", "19/10/2024","29/10/2024","27/11/2024",
                       "27/05/2025"),
          options = list(
            `selected-text-format` = "static",    # Mantener el texto estático
            `style` = "btn-primary",              # Estilo del botón
            `title` = "RELEASE_DATE",             # Texto fijo
            `actions-box` = TRUE,
            `select-all-text` = "(Select)",
            `deselect-all-text` = "( )"
          ),
        ),
         
        # Añadir segundo pickerInput para el segundo conjunto de datos
        pickerInput(
          inputId = "checkbox_dropdown_2",
          label = NULL,
          choices = c("design", "ongoing", "progress", "ready", "third", "approval", "bypass",
                      "hold", "internal", "infra", "audit", "external", "done"),  
          multiple = TRUE,
          selected = c("design", "ongoing", "progress", "ready", "third", "approval", "bypass",
                      "hold", "internal", "infra", "audit", "external", "done"),
          options = list(
            `selected-text-format` = "static",
            `style` = "btn-warning",
            `title` = "PROJ_STATUS",
            `actions-box` = TRUE,
            `select-all-text` = "(Select)",
            `deselect-all-text` = "( )"
          )
        ),
        div(class = "subtitulo", "execute..."), 
        actionButton("button2", "Ongoing", class = "btn-custom"),
        actionButton("button4", "Metrics", class = "btn-custom"),
        actionButton("refresh", "Refresh Data", class = "btn-custom refresh-btn")
      )
    ),
    div(class = "right-panel",
      plotOutput("canvas", width = "100%", height = "auto")
    )
  )
)


# Carga las librerías necesarias
library(shiny)
library(readxl)
library(dplyr)
library(openxlsx)
library(ggplot2)
library(tidyr)
library(stringi)
library(stringr)
library(data.table)
library(lubridate)
library(gridExtra)
library(memoise)  # Para cachear resultados
library(rlang)

# Define la lógica del servidor
server <- function(input, output, session) {

  # 1. Variables reactivas para almacenar los datos cargados ----
  reactive_data <- reactiveValues(
    df_dashboard = NULL,
    df_finalizadas = NULL,
    df_combined = NULL,
    last_refresh = NULL,
    processed_data = NULL  # Almacenará datos procesados
  )

  # Carga inicial de datos
  observe({
    load_all_data()
  })

  # Función para definir la ruta y las columnas a usar
  get_file_info <- function() {
    ruta_excel <- "./dashboard.xlsx"
    columns_to_use <- c("ProjectCode", "Province", "Release Date", "Circuit Type",
                        "Relocation Type", "Project Status", "Requisite_1",
                        "Requisite_2", "Building Code", "Design Date",
                        "Migration_Code", "Equipment", "Job Date", "Contractor",
                        "JOB_CODE", "JOB STATUS", "App_Date", "Hour", 
                        "Current Stock")
    return(list(ruta_excel = ruta_excel, columns_to_use = columns_to_use))
  }

  # Carga de datos de la pestaña 'ONGOING'
  load_dataframe <- function() {
    file_info <- get_file_info()
    tryCatch({
      old_warn <- options(warn = -1)
      df_dashboard <- suppressWarnings(read_excel(file_info$ruta_excel,
                                               sheet = "ONGOING",
                                               col_names = TRUE,
                                               skip = 1,
                                               na = character()))
      options(old_warn)


      # Verificar si las columnas especificadas existen en el dataframe
      missing_columns <- setdiff(file_info$columns_to_use, names(df_dashboard))
      if (length(missing_columns) > 0) {
        stop(paste("NO SE ENCUENTRAN LAS COLUMNAS:",
                   paste(missing_columns, collapse = ", ")))
      }
      df_dashboard <- df_dashboard %>% select(all_of(file_info$columns_to_use))
      if (is.null(df_dashboard) ||
            nrow(df_dashboard) == 0) stop("El DataFrame está vacío o es NULL.")
      df_dashboard <- df_dashboard[!is.na(df_dashboard$ProjectCode) & df_dashboard$ProjectCode != "", ]
      ## Asegurar que la columna "Design Date" tenga el mismo tipo (datetime)
      df_dashboard$`Design Date` <- as.character(df_dashboard$`Design Date`)
      rownames(df_dashboard) <- NULL
      return(df_dashboard)
    }, error = function(e) {
      stop(" ", e$message)
      return(NULL)
    })
  }

  # Carga de datos de la pestaña 'FINISHED'
  load_finalizadas <- function() {
    # Llamada a la función que obtiene la ruta y las columnas
    file_info <- get_file_info()
    tryCatch({
      # Suprimir warnings temporales
      old_warn <- options(warn = -1)
      # Leer el archivo Excel con la ruta proporcionada por get_file_info
      df_finalizadas <- suppressWarnings(
                                         read_excel(file_info$ruta_excel,
                                                    sheet = "FINISHED",
                                                    col_names = TRUE,
                                                    skip = 1,
                                                    na = character()))
      # Restaurar opciones originales después
      options(old_warn)
      # Filtrar para mantener solo columnas especificadas en 'columns_to_use'
      df_finalizadas <- df_finalizadas %>%
        select(all_of(file_info$columns_to_use))
      # Verificar si df_finalizadas es NULL o está vacío
      if (is.null(df_finalizadas)) {
        stop("El DataFrame de FINISHED es NULL.")
      }
      if (nrow(df_finalizadas) == 0) {
        stop("DataFrame de FINISHED vacío después de la carga inicial.")
      }
      # Ignorar las filas que no tengan datos en la columna 'ProjectCode'
      df_finalizadas <- df_finalizadas[
        !is.na(df_finalizadas$ProjectCode) & df_finalizadas$ProjectCode != "",
      ]
      # CONVERSIÓN: Convertir a texto las columnas "Design Date" y "App_Date"
      df_finalizadas$`Design Date` <- as.character(df_finalizadas$`Design Date`)  
      # Asegurarse de que el índice comience en 1 (por defecto en R)
      rownames(df_finalizadas) <- NULL
      return(df_finalizadas)
    }, error = function(e) {
      message("Error al leer el archivo Excel: ", e$message)
      return(NULL)
    })
  }

  ############## FILTRO RELEASE DATE ################

  # Función única mejorada (reemplaza ambas)
  filter_by_relaese_dates <- function(df_dashboard, fechas) {
    req(df_dashboard)
    if (is.null(fechas)) return(NULL)

    fechas <- as.Date(fechas, format = "%d/%m/%Y")
    df_dashboard$Fecha_Clohe_Temporal <- as.Date(
      sub(" UTC", "", df_dashboard$`Release Date`),
      format = "%Y-%m-%d"
    )
    df_filtrado <- df_dashboard[df_dashboard$Fecha_Clohe_Temporal %in% fechas, ]
    df_filtrado$Fecha_Clohe_Temporal <- NULL
    return(df_filtrado)
  }

  ###################################################
  ############ VARIABLES REACTIVAS ##################

  # Variable reactiva temporal para capturar estado actual
  # de checkbox_dropdown_1
  temp_fechas_referencia <- reactive({
    input$checkbox_dropdown_1
  })

  temp_estado_referencia <- reactive({
    input$checkbox_dropdown_2
  })
  # Actualizar fechas_referencia solo cuando se presiona button2
  fechas_referencia <- reactiveVal(NULL)
  estado_referencia <- reactiveVal(NULL)

  observeEvent(input$button2, {
    req(reactive_data$df_combined)
    fechas_referencia(temp_fechas_referencia())
    estado_referencia(temp_estado_referencia())
    selected_button("button2")
    selected_value_2(input$combo2)
  })

  #####################################################
  ########## FUNCIONES PARA LAS MÉTRICAS ##############

  combine_dataframes <- function(df_dashboard, df_finalizadas) {
    df_combined <- bind_rows(df_dashboard, df_finalizadas)
    return(df_combined)
  }
  # Función que genera las métricas en base a las fechas seleccionadas
  generar_metricas <- function(df) {
    # Ejemplo de métricas calculadas, puedes ajustar esto a las que necesites
    total_proyectos <- nrow(df)
    proyectos_finalizados <- sum(
      df$`Current Stock` == "DONE",
      na.rm = TRUE
    )
    porcentaje_finalizados <- round(
      (proyectos_finalizados / total_proyectos) * 100,
      2
    )
    return(list(
      total_proyectos = total_proyectos,
      proyectos_finalizados = proyectos_finalizados,
      porcentaje_finalizados = porcentaje_finalizados
    ))
  }

  # Función para mostrar las métricas en el UI
  mostrar_metricas <- function(metrica) {
    formato <- paste0(
      "Total Proyectos: %d\n",
      "Proyectos Finalizados: %d\n",
      "percentage Finalizados: %.2f%%"
    )
    sprintf(formato,
            metrica$total_proyectos,
            metrica$proyectos_finalizados,
            metrica$porcentaje_finalizados)
  }

  #########################################################
  ####### FUNCIONES CENTRALES PEQUEÑAS (INICIO) ###########

  # función para procesar datos comunes
  process_data <- function(df, group_by_column, category_labels) {
    data <- list(
      `Main_Category` = character(0),
      Subcategory = list(),
      Valor = list(),
      percentage = list()
    )
    caracteristica_labels <- c("Classif.", "Design", "WorkOrder", "AppJob")
    for (category in category_labels) {
      group <- subset(df, df[[group_by_column]] == category)
      if (nrow(group) > 0) {
        data$`Main_Category` <- c(data$`Main_Category`, category)
        Subcategory <- unique(group$ProjectCode)
        data$Subcategory[[length(data$Subcategory) + 1]] <- Subcategory
        Valor <- list()
        porcentajes <- list()
        for (atlas in Subcategory) {
          atlas_subset <- subset(group, ProjectCode == atlas)
          filtered_subset <- atlas_subset
          char_row <- c()
          Porcentaje_row <- c()
          for (characteristic in caracteristica_labels) {
            result <- evaluate_characteristic(filtered_subset, characteristic)
            char_row <- c(char_row, result$value)
            Porcentaje_row <- c(Porcentaje_row, result$percentage)
          }
          Valor[[length(Valor) + 1]] <- char_row
          porcentajes[[length(porcentajes) + 1]] <- Porcentaje_row
        }
        data$Valor[[length(data$Valor) + 1]] <- Valor
        data$percentage[[length(data$percentage) + 1]] <- porcentajes
      }
    }
    return(data)
  }

  # 2. Memoise para funciones costosas que no cambian frecuentemente
  memoised_load_dataframe <- memoise(load_dataframe,
                                     cache = cache_filesystem("cache"))
  memoised_load_finalizadas <- memoise(load_finalizadas,
                                       cache = cache_filesystem("cache"))
  memoised_process_data <- memoise(process_data,
                                   cache = cache_filesystem("cache"))

  # Función para cargar datos
  load_all_data <- function() {
    tryCatch({
      # Cargar datos
      df_dashboard <- memoised_load_dataframe()
      df_finalizadas <- memoised_load_finalizadas()

      # Combinar los dataframes si ambos se cargaron correctamente
      if (!is.null(df_dashboard) && !is.null(df_finalizadas)) {
        # Primero asigna los dataframes individuales
        reactive_data$df_dashboard <- df_dashboard
        reactive_data$df_finalizadas <- df_finalizadas

        # Luego crea el combinado
        df_combined <- combine_dataframes(df_dashboard, df_finalizadas)
        reactive_data$df_combined <- df_combined

        # Precálculo de datos usados frecuentemente (en memoria)
        reactive_data$processed_data <- list(
          estado = evaluate_central_estado(df_combined),
          fecha_btp = fecha_prevista_btp(df_combined),
          ventana_btp = ventana_prevista_btp(df_combined),
          provincias = extraer_provincia(df_combined),
          eecc = extraer_eecc(df_combined),
          num_ri = extraer_numero_ri(df_combined),
          release_date = extract_release_date(df_combined)
        )
      }

      reactive_data$last_refresh <- Sys.time()

    # Mostrar notificación de éxito
      showNotification("Datos actualizados correctamente", type = "message")
    }, error = function(e) {
      showNotification(paste("Error al cargar datos:", e$message),
                       type = "error")
    })
  }
  
  # Cargar datos al iniciar la aplicación ----
  observe({
    load_all_data()
  })

  # Observador para el botón de refresco
  observeEvent(input$refresh, {
    # Limpiar la caché antes de recargar
    forget(memoised_load_dataframe)
    forget(memoised_load_finalizadas)
    forget(memoised_process_data)

    # Limpiar directorio de caché físicamente
    unlink("cache", recursive = TRUE)
    dir.create("cache")

    # Limpiar datos reactivos
    reactive_data$df_dashboard <- NULL
    reactive_data$df_finalizadas <- NULL
    reactive_data$df_combined <- NULL
    reactive_data$processed_data <- NULL
    
    load_all_data()
  })

  #Versión optimizada de prepare_data usando cache
  prepare_data_optimized <- function(main_category_column) {
    # Verificar que tenemos los datos necesarios
    req(reactive_data$df_dashboard)

    #Filtrar por fechas seleccionadas
    df_filtrado <- filter_by_relaese_dates(
      reactive_data$df_dashboard,
      fechas_referencia()
    )

    #Si no hay coincidencias, devolver NULL
    if (nrow(df_filtrado) == 0) {
      return(NULL)
    }

    #Obtener categorías únicas
    unique_main_categories <- unique(df_filtrado[[main_category_column]])
    is_date_column <- inherits(df_filtrado[[main_category_column]], "Date")
    sorted_main_categories <- if (is_date_column) {
      sort(unique_main_categories)
    } else {
      sort(unique_main_categories)
    }

    # 3. Procesar los datos (usando la función memoizada)
    data <- memoised_process_data(
      df_filtrado,
      main_category_column,
      sorted_main_categories
    )

    # 4. Retornar estructura con datos preprocesados
    return(list(
      data = data,
      caracteristica_labels = c("Classif.", "Design", "WorkOrder", "AppJob"),
      central_estado = reactive_data$processed_data$estado,
      prevision_btp = reactive_data$processed_data$fecha_btp,
      ventana_btp = reactive_data$processed_data$ventana_btp,
      provincia = reactive_data$processed_data$provincias,
      emp_colab = reactive_data$processed_data$eecc,
      extraccion_num_ri = reactive_data$processed_data$num_ri,
      fechas_clohe = reactive_data$processed_data$release_date
    ))
  }

  evaluate_characteristic <- function(subset, characteristic) {
    if (characteristic == "Classif.") {
      return(evaluate_estudio(subset))
    } else if (characteristic == "Design") {
      return(evaluate_diseno(subset))
    } else if (characteristic == "WorkOrder") {
      return(evaluate_orden_atlas(subset))
    } else if (characteristic == "AppJob") {
      return(evaluate_btp(subset))
    } else {
      return(list(value = 0, percentage = 0))
    }
  }
  evaluate_estudio <- function(df_subset) {
    # Filtrar las filas donde 'Circuit Type' no sea 'RELOCATION' ni '¿?'
    estudio_subset <- subset(
      df_subset,
      !(`Circuit Type` %in% c("RELOCATION", "¿?"))
    )
    if (nrow(estudio_subset) == 0) {
      return(list(value = 0, percentage = 0))
    }
    count_total <- nrow(estudio_subset)
    evaluate_row <- function(row) {
      tipo_corte <- row[["Relocation Type"]]
      if (tipo_corte %in% c("Sevice Cancellation", 
                            "N/A",
                            "Not To Reroute",
                            "Third-Parties Pending",
                            "Reroute Study",
                            "Third-Parties Study")) {
        return(1)
      } else if (tipo_corte %in% c("Relocation_Type_1",
                                   "Relocation_Type_1&2",
                                   "Relocation_Type_2")) {
        if (isTRUE(row[["Migration_Code"]] == "normalize")) {
          return(1)
        }
        cambio_terminal_valid <-
          !is.na(row[["Requisite_1"]]) &&
          nchar(trimws(row[["Requisite_1"]])) > 0
        central_entrega_valid <-
          !is.na(row[["Requisite_2"]]) &&
          nchar(trimws(row[["Requisite_2"]])) > 0
        return(ifelse(cambio_terminal_valid && central_entrega_valid, 1, 0))
      } else {
        return(0)
      }
    }
    count_valid <- sum(apply(estudio_subset, 1, evaluate_row))
    value <- ifelse(
      count_valid == count_total,
      1,
      ifelse(count_valid > 0, 2, 0)
    )
    percentage <- ifelse(
      count_total > 0,
      round((count_valid / count_total) * 100),
      0
    )
    #print(list(value = value, percentage = percentage))
    return(
      list(
        value = value,
        percentage = percentage
      )
    )
  }

  ######################
  # Aplicar la función es_fecha_o_convertible a la columna 'Design Date'
  es_fecha_o_convertible <- function(valor) {
    if (is.numeric(valor) && !is.na(valor)) {
      posible_fecha <- as.Date(valor, origin = "1899-12-30")
      return(TRUE)
    }
    if (is.character(valor) && valor != "" &&
        toupper(valor) != "N/A" && !is.na(valor)) {
      posible_fecha <- suppressWarnings(as.Date(valor, format = "%Y-%m-%d"))
      if (!is.na(posible_fecha)) {
        return(TRUE)
      }
      posible_numero <- suppressWarnings(as.numeric(valor))
      if (!is.na(posible_numero)) {
        posible_fecha <- as.Date(posible_numero, origin = "1899-12-30")
        return(TRUE)
      }
    }
    return(FALSE)
  }
    
  evaluate_diseno <- function(df_subset) {
    # Filtrar filas que cumpla condición 'Relocation Type' y 'Circuit Type'
    diseno_subset <- df_subset %>%
      filter(
        `Relocation Type` %in% c("Relocation_Type_1",
                               "Relocation_Type_1&2",
                               "Relocation_Type_2") |
          grepl("RELOCATION", `Circuit Type`, ignore.case = TRUE)
      )
    # Si no hay filas en el subconjunto, devuelve un valor por defecto
    if (nrow(diseno_subset) == 0) {
      return(list(value = 0, percentage = 0))
    }
    # Evaluar las condiciones 'Building Code' y 'Design Date'
    diseno_subset <- diseno_subset %>%
      mutate(
        # Condición 1: Building Code debe ser válido 
        # (solo para "Relocation_Type_1" y "Relocation_Type_1&2")
        proyecto_sgipe_valid = !is.na(`Building Code`) &
          nchar(trimws(`Building Code`)) > 0,
        # Condición 2: Evaluar si 'Design Date' es válida utilizando la 
        # función 'es_fecha_o_convertible'
        fecha_diseno_valid = sapply(`Design Date`, es_fecha_o_convertible),
        # Aplicar las validaciones basadas en el 'Relocation Type'
        valid = case_when(
          `Relocation Type` %in%
            c("Relocation_Type_1", "Relocation_Type_1&2") ~
            proyecto_sgipe_valid & fecha_diseno_valid,
          `Circuit Type` == "RELOCATION" ~
            proyecto_sgipe_valid & fecha_diseno_valid,
          `Relocation Type` == "Relocation_Type_2" ~
            !is.na(suppressWarnings(as.numeric(Migration_Code))) & suppressWarnings(as.numeric(Migration_Code)) %% 1 == 0,
          TRUE ~ FALSE  # Por si acaso
        )
      )

    # Contar cuántas filas son válidas
    count_valid <- sum(diseno_subset$valid)
    count_total <- nrow(diseno_subset)
    # Calcular el valor y el porcentaje
    value <-
      ifelse(count_valid == count_total,
        1,
        ifelse(count_valid > 0, 2, 0)
      )
    percentage <-
      ifelse(count_total > 0,
        round((count_valid / count_total) * 100),
        0
      )
    return(list(value = value, percentage = percentage))
  }

  ######################
  evaluate_orden_atlas <- function(df_subset) {
    # Filtrar filas donde 'Circuit Type' no sea 'RELOCATION', '¿?' ni 'SSFO'
    orden_subset <- df_subset %>%
      filter(
        !`Circuit Type` %in% c("RELOCATION", "¿?", "SSFO") &
          !is.na(`Relocation Type`) &
          `Relocation Type` %in% c(
            "Relocation_Type_1",
            "Relocation_Type_1&2",
            "Relocation_Type_2"
          )
      )
    # Si no hay filas en el subconjunto, devolver un valor por defecto
    if (nrow(orden_subset) == 0) {
      return(list(value = 1, percentage = 100))
    }
    # Usar mutate() para agregar una columna 'valid' con condiciones requeridas
    orden_subset <- orden_subset %>%
      mutate(
        # Si valor de 'Migration_Code' es 'normalize' = válido
        valid = case_when(
          !is.na(Migration_Code) &
            trimws(Migration_Code) == "normalize" ~ 1,
          # Validar si Migration_Code y Equipment tienen datos
          !is.na(Migration_Code) & nchar(trimws(Migration_Code)) > 0 &
            !is.na(Equipment) & nchar(trimws(Equipment)) > 0 ~ 1,
          TRUE ~ 0
        )
      )
    # Contar cuántas filas son válidas
    count_valid <- sum(orden_subset$valid)
    count_total <- nrow(orden_subset)

    # Calcular el valor y el porcentaje como antes
    value <-
      ifelse(count_valid == count_total,
        1,
        ifelse(count_valid > 0, 2, 0)
      )
    percentage <-
      ifelse(count_total > 0,
        round((count_valid / count_total) * 100),
        0
      )
    return(list(value = value, percentage = percentage))
  }

  evaluate_btp <- function(df_subset) {
    # Filtrar filas donde 'Circuit Type' no sea 'RELOCATION', '¿?' ni 'SSFO'
    btp_subset <- df_subset %>%
      filter(!`Circuit Type` %in% c("RELOCATION", "¿?", "SSFO") &
               !is.na(`Relocation Type`) &
               `Relocation Type` %in% c("Relocation_Type_1",
                                      "Relocation_Type_1&2",
                                      "Relocation_Type_2"))

    # Si no hay filas en subconjunto, devolver un valor por defecto
    if (nrow(btp_subset) == 0) {
      return(list(value = 1, percentage = 100))
    }

    # Usar mutate() para agregar columna 'valid' con las condiciones requeridas
    btp_subset <- btp_subset %>%
      mutate(
        btp_valid = !is.na(JOB_CODE) & trimws(JOB_CODE) != "",
        finalizado_done = !is.na(`Current Stock`) &
          toupper(trimws(`Current Stock`)) == "DONE",
        estado_autorizado = !is.na(`JOB STATUS`) &
          toupper(trimws(`JOB STATUS`)) == "AUTHORIZED",
        valid = if_else((finalizado_done | estado_autorizado) & btp_valid, 1, 0)
      )
    # Contar cuántas filas son válidas
    count_valid <- sum(btp_subset$valid)
    count_total <- nrow(btp_subset)
    # Calcular el valor y el porcentaje como antes
    value <- ifelse(
      count_valid == count_total,
      1,
      ifelse(count_valid > 0, 2, 0)
    )
    percentage <- ifelse(
      count_total > 0,
      round((count_valid / count_total) * 100),
      0
    )

    return(list(value = value, percentage = percentage))
  }

  # Función convertir números seriales de Excel en fechas con formato DD-MM-YYYY
  convertir_a_fecha <- function(valor) {
    tryCatch({
      num_valor <- as.numeric(valor)
      if (!is.na(num_valor)) {
        format(as.Date(num_valor, origin = "1899-12-30"), "%d-%m-%Y")
      } else {
        NA
      }
    }, warning = function(w) {
      NA
    }, error = function(e) {
      NA
    })
  }

  # Función procesar la columna 'App_Date' y obtener la fecha más cercana por 'ProjectCode'
  fecha_prevista_btp <- function(df_dashboard) {
    # Obtener la fecha actual
    hoy <- Sys.Date()
    # Limpia valores no válidos (N/A, texto) y convertir columna 'App_Date' a fecha
    df_dashboard <- df_dashboard %>%
      mutate(App_Date = sapply(App_Date, convertir_a_fecha)) %>%
      mutate(Dia_valida = as.Date(App_Date, format = "%d-%m-%Y")) # Convertir a fecha
    # Filtrar solo las fechas válidas (fechas de hoy o futuras)
    df_validas <- df_dashboard %>%
      filter(!is.na(Dia_valida) & Dia_valida >= hoy)  # Filtrar fechas válidas
    # Agrupa por 'ProjectCode' y selección fecha más cercana (la mínima) si hay varias
    df_agrupado <- df_validas %>%
      group_by(ProjectCode) %>%
      summarize(
        Fecha_Representativa = min(Dia_valida, na.rm = TRUE) #Selec fecha mínima
      ) %>%
      ungroup()
    # Crear lista de todas las centrales 'ProjectCode' con sus fechas o vacíos
    result_list <- df_dashboard %>%
      distinct(ProjectCode) %>%  # Mantener solo los valores únicos de ProjectCode
      left_join(df_agrupado, by = "ProjectCode") %>%  # Unir con fechas representati
      mutate(
        Fecha_Representativa = ifelse(
          is.na(Fecha_Representativa),
          "",
          format(Fecha_Representativa, "%d-%m-%Y")
        )
      ) # NAs x vacíos
    # Crear las dos listas: 'ProjectCode' y 'fechaBtp'
    ProjectCode <- result_list$ProjectCode
    fechaBtp <- result_list$Fecha_Representativa
    # Devolver las dos listas
    return(list(ProjectCode = ProjectCode, fechaBtp = fechaBtp))
  }

  clasificar_turno <- function(h) {
    # Manejo rápido de casos especiales
    if (is.na(h) ||
          h == "" ||
          tolower(h) %in% c("n/a", "na"))
      return(NA_character_)

    h_lower <- tolower(trimws(h))
    if (h_lower == "diurno") return("DAY")

    # Manejo numérico (valores de tiempo de Excel)
    if (grepl("^\\d+\\.\\d+$", h)) {
      hora_num <- as.numeric(h) * 24
      hora <- floor(hora_num)
      if (hora >= 24) hora <- 0
      return(ifelse(hora >= 20 | hora < 7, "NITE", "DAY"))
    }

    # Extraer hora de texto
    hora_limpia <- gsub("^0|:.*|-.*|\\s", "", h_lower)
    hora_num <- suppressWarnings(as.numeric(hora_limpia))
    if (is.na(hora_num)) hora_num <- 0

    # Clasificación final
    ifelse(hora_num >= 20 | hora_num < 6, "NITE", "DAY")
  }

  ventana_prevista_btp <- function(df_dashboard) {
    # Validación inicial de columnas requeridas
    if (!all(c("ProjectCode", "App_Date", "Hour") %in% names(df_dashboard))) {
      stop("El dataframe debe contener las columnas 'ProjectCode', 'App_Date' y 'Hour'")
    }
    hoy <- Sys.Date()

    # Conservar el orden original único de los ProjectCode
    atlas_orden_original <- unique(df_dashboard$ProjectCode)

    # Procesamiento seguro con manejo de errores
    result <- tryCatch({
      # Paso 1: Procesar los datos válidos
      df_procesado <- df_dashboard %>%
        mutate(
          Dia_valida = as.Date(
            sapply(App_Date, convertir_a_fecha),
            format = "%d-%m-%Y"
          ),
          Turno = sapply(Hour, clasificar_turno)
        ) %>%
        filter(
          !is.na(Dia_valida) &
            Dia_valida >= hoy &
            !is.na(Turno) &
            Turno != ""
        )

      # Paso 2: Obtener la ventana para cada ProjectCode (fecha más cercana)
      df_ventanas <- if (nrow(df_procesado) > 0) {
        df_procesado %>%
          group_by(ProjectCode) %>%
          arrange(Dia_valida) %>%
          summarise(
            Ventana = first(Turno),
            .groups = "drop"
          )
      } else {
        data.frame(ProjectCode = character(), Ventana = character())
      }

      # Paso 3: Crear resultado manteniendo el orden original
      data.frame(
        ProjectCode = atlas_orden_original,
        stringsAsFactors = FALSE
      ) %>%
        left_join(df_ventanas, by = "ProjectCode") %>%
        mutate(Ventana = ifelse(is.na(Ventana), "", Ventana))

    }, error = function(e) {
      warning("Error en procesamiento: ", e$message)
      data.frame(
        ProjectCode = atlas_orden_original,
        Ventana = "",
        stringsAsFactors = FALSE
      )
    })
    # Devolver resultado manteniendo el orden original
    result_list <- list(
      ProjectCode = result$ProjectCode,
      ventanaBtp = result$Ventana
    )
    return(result_list)
  }

  evaluate_central_estado <- function(df) {
    # Filtrar las filas donde 'Circuit Type' es 'RELOCATION'
    filtered_df <- df[df[["Circuit Type"]] == "RELOCATION", ]
    # Inicializar una lista vacía para almacenar los resultados
    result_list <- list(
      ProjectCode = filtered_df[["ProjectCode"]],
      Estado = character(nrow(filtered_df))
    )
    # Recorrer cada fila del dataframe filtrado
    for (i in 1:nrow(filtered_df)) {
      # Convertir a minúsculas para evitar problemas con mayúsculas/minúsculas
      estado_central <- tolower(trimws(filtered_df[i, "Project Status"]))
      if (grepl("Bypass", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "bypass"
      } else if (grepl("Design", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "design"
      } else if (grepl("Progress", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "progress"
      } else if (grepl("Hold", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "hold"
      } else if (grepl("Ready", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "ready"
      } else if (grepl("Approval", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "approval"
      } else if (grepl("Third", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "third"
      } else if (grepl("Internal", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "internal"
      } else if (grepl("Infra", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "infra"
      } else if (grepl("Audit", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "audit"
      } else if (grepl("External", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "external"
      } else if (grepl("Completed", estado_central, ignore.case = TRUE)) {
        result_list$Estado[i] <- "done"
      } else {
        result_list$Estado[i] <- "ongoing"  # Cualquier otro valor
      }
    }
    return(result_list)
  }

  # Función extraer provincia basada en columna 'ProjectCode' del dataframe
  extraer_provincia <- function(df_dashboard) {
    # Filtrar los valores únicos de 'ProjectCode' y 'Province'
    unique_atlas_provincia <- unique(df_dashboard[, c("ProjectCode", "Province")])
    # Inicializar la lista para almacenar los resultados
    result_list <- list(
      ProjectCode = unique_atlas_provincia$ProjectCode,
      Province = unique_atlas_provincia$Province
    )
    return(result_list)
  }
  # Función extraer fecha clohe basada de columna 'Release Date' del dataframe
  extract_release_date <- function(df_dashboard) {
    # Filtrar los valores únicos de 'ProjectCode' y 'Province'
    unique_projectcode_releasedate <- unique(df_dashboard[, c("ProjectCode", "Release Date")])
    # Inicializar la lista para almacenar los resultados
    result_list <- list(
      ProjectCode = unique_projectcode_releasedate$ProjectCode,
      ReleaseDate = unique_projectcode_releasedate$"Release Date"
    )
    return(result_list)
  }

  extraer_eecc <- function(df_dashboard) {
    # Filtrar solo RELOCATION y extraer valores únicos
    result <- df_dashboard %>%
      filter(`Circuit Type` == "RELOCATION") %>%
      select(ProjectCode, `Contractor`) %>%
      distinct(ProjectCode, .keep_all = TRUE)  # Garantiza un único valor por ProjectCode

    # Devolver como lista nombrada
    result_list <- list(
      ProjectCode = result$ProjectCode,
      eecc = result$`Contractor`  # Valor literal de Contractor
    )
    return(result_list)
  }

  get_ri_category <- function(count) {
    # Asegurarse de que count sea un número entero positivo
    count <- as.integer(count)
    # Restar una unidad y formatear con 2 dígitos
    ri_value <- sprintf("%02dCK", max(0, count - 1))
    return(ri_value)
  }

  extraer_numero_ri <- function(df_dashboard) {
    # Filtra el DF original para quedarse solo con tipos de corte deseados
    df_filtered <- subset(
      df_dashboard,
      `Relocation Type` %in% c("Relocation_Type_1", 
                             "Relocation_Type_2", 
                             "Relocation_Type_1&2", 
                             "") | is.na(`Relocation Type`) |
      `Circuit Type` == "RELOCATION"
    )
    # Cuenta cuántas veces aparece cada 'ProjectCode' en ese subconjunto
    atlas_counts <- table(df_filtered$ProjectCode)

    # 3) Convierte las tablas a vectores
    atlas_vec <- names(atlas_counts)
    count_vec <- as.integer(atlas_counts)

    # 4) Aplica 'get_ri_category' a cada conteo
    category_vec <- sapply(count_vec, get_ri_category)

    # 5) Devuelve el resultado
    #    (aquí lo retornamos como lista, siguiendo el estilo de 'extraer_eecc')
    result_list <- list(
      ProjectCode       = atlas_vec,
      RI_Category = category_vec
    )
    return(result_list)
  }

  ################# FUNCIONES CENTRALES ONGOING (Fin) ##########################
  ##################### FUNCIONES GRÁFICAS (Inicio) ############################
  ###################### 1. PLOT LOLLIPOP (Inicio) #############################

  ordenar_dataframe <- function(df, criterio) {
    # Verificar que el dataframe no esté vacío
    if (nrow(df) == 0) {
      stop("El dataframe está vacío. No se puede ordenar.")
    }

    # Verificar que las columnas necesarias existan
    required_columns <- c("Main_Category",
                          "Province",
                          "Suma_Porcentaje",
                          "Subcategory")

    missing_columns <- setdiff(required_columns, colnames(df))

    if (length(missing_columns) > 0) {
      warning("Las siguientes columnas no existen en el dataframe: ",
              paste(missing_columns, collapse = ", "))
      # Continuar solo con las columnas que existen
      required_columns <- intersect(required_columns, colnames(df))
    }

    # Función auxiliar para crear columnas temporales
    crear_columnas_temporales <- function(df) {
      df %>%
        mutate(
          Main_Category_orden = as.Date(Main_Category, format = "%d-%m-%Y"),
          Provincia_no_tildes = stri_trans_general(Province, "Latin-ASCII")
        )
    }

    # Función auxiliar para eliminar columnas temporales
    eliminar_columnas_temporales <- function(df) {
      df %>% select(-c(Main_Category_orden, Provincia_no_tildes))
    }

    # Función auxiliar para ordenar el dataframe
    ordenar <- function(df, ...) {
      df %>% arrange(...)
    }

    if (criterio == "RELEASE DATE") {
      # Verificar que Main_Category tenga el formato esperado
      if (!all(grepl("^\\d{2}-\\d{2}-\\d{4}$", df$Main_Category))) {
        stop("La columna 'Main_Category' no tiene el formato 'dd-mm-yyyy'.")
      }
      # Crear columnas temporales
      df <- df %>% crear_columnas_temporales()
      # Ordenar el dataframe usando la función auxiliar
      df <- df %>%
        ordenar(
          desc(Main_Category_orden),
          desc(Provincia_no_tildes),
          Suma_Porcentaje,
          desc(Subcategory)
        )
      # Eliminar columnas temporales
      df <- df %>% eliminar_columnas_temporales()

    } else if (criterio == "TEAM") {
      df <- df %>%
        crear_columnas_temporales() %>%
        ordenar(
          desc(TEAM),
          desc(Main_Category_orden),
          desc(Provincia_no_tildes),
          Suma_Porcentaje,
          desc(Subcategory)
        ) %>%
        eliminar_columnas_temporales()

    } else if (criterio == "BTP") {
      if (!"Fecha_btp" %in% colnames(df)) {
        stop("La columna 'Fecha_btp' no existe en el dataframe.")
      }
      df <- df %>%
        mutate(
          Fecha_btp = ifelse(is.na(Fecha_btp), "", as.character(Fecha_btp)),
          Fecha_btp_orden = ifelse(Fecha_btp == "",
                                   NA,
                                   as.Date(Fecha_btp, format = "%d-%m-%Y"))
        ) %>%
        crear_columnas_temporales() %>%
        ordenar(
          Fecha_btp != "",
          desc(Fecha_btp_orden),
          desc(Main_Category_orden),
          desc(Provincia_no_tildes),
          Suma_Porcentaje,
          desc(Subcategory)
        ) %>%
        eliminar_columnas_temporales() %>%
        select(-Fecha_btp_orden) %>%  # Eliminar la columna temporal
        mutate(
          # Convertir NA de nuevo a cadenas vacías para la visualización
          Fecha_btp = ifelse(is.na(Fecha_btp), "", as.character(Fecha_btp))
        )

    } else if (criterio == "STATUS") {
      df <- df %>%
        crear_columnas_temporales() %>%
        ordenar(
          desc(Estado),
          desc(Main_Category_orden),
          desc(Provincia_no_tildes),
          Suma_Porcentaje,
          desc(Subcategory)
        ) %>%
        eliminar_columnas_temporales()

    } else if (criterio == "NUMBER CRC") {
      df <- df %>%
        crear_columnas_temporales() %>%
        ordenar(
          desc(NUM_RI),
          desc(Main_Category_orden),
          desc(Provincia_no_tildes),
          Suma_Porcentaje,
          desc(Subcategory)
        ) %>%
        eliminar_columnas_temporales()

    } else {
      # Ordenación por defecto
      df <- df %>%
        ordenar(desc(Main_Category), Suma_Porcentaje)
    }

    return(df)
  }

  plot_lollipop_chart <- function() {
    # Establecer "RELEASE DATE" como valor fijo para main_category_column
    main_category_column <- "RELEASE DATE"

    if (main_category_column == "RELEASE DATE") {
      result <- prepare_data_optimized(main_category_column = "Release Date")
      # Convertir las fechas aquí, justo después de obtener los datos
      result$data$`Main_Category` <- sapply(
        result$data$`Main_Category`,
        function(x) {
          if (grepl("^[0-9]+$", x)) {
            x_numeric <- as.numeric(x)
            x_date <- as.POSIXct(x_numeric,
                                 origin = "1970-01-01",
                                 tz = "UTC")
            format(x_date, "%d-%m-%Y")
          } else {
            warning(sprintf("Valor inesperado en la conversión de fecha: %s",
                            x))
            x
          }
        }
      )
    } else {
      stop("El argumento debe ser 'Province', 'Release Date' o 'NUMBER CRC'.")
    }
    data <- result$data
    x_labels <- result$caracteristica_labels
    estado <- result$central_estado
    Fecha_btp <- result$prevision_btp
    Ventana_btp <- result$ventana_btp
    Provincias <- result$provincia
    Eecc <- result$emp_colab
    Num_RI <- result$extraccion_num_ri
    # Aplanar los datos del objeto 'data' para crear un dataframe
    df <- data.frame(
      Main_Category = rep(
        data$`Main_Category`,
        times = sapply(data$Subcategory, length) * length(x_labels)
      ),
      Subcategory = rep(unlist(data$Subcategory), each = length(x_labels)),
      Caracteristica = rep(x_labels, times = length(unlist(data$Subcategory))),
      Valor = unlist(data$Valor),
      percentage = unlist(data$percentage)
    )
    # Convertir columna 'Caracteristica' a factor y especificar orden deseado
    df$Caracteristica <- factor(df$Caracteristica, levels = x_labels)

    #### Add datos al df de referencia ####
    ########################################

    # Unir df con estado basado en columna ProjectCode (estado$ProjectCode y estado$Estado)
    estado_df <- data.frame(ProjectCode = estado$ProjectCode, Estado = estado$Estado)
    # Unir estado con df
    df <- left_join(df, estado_df, by = c("Subcategory" = "ProjectCode"))

    # Filtrar df basado en las selecciones de estado_referencia
    df <- df[df$Estado %in% estado_referencia(), ]

    # Verificar si df está vacío después del filtrado
    if (nrow(df) == 0) {
      # Devolver un mensaje o un gráfico vacío
      plot <- ggplot() + 
        annotate("text",
                 x = 0.5,
                 y = 0.5,
                 label = "No hay datos para los estados seleccionados") +
        theme_void()
      return(list(plot = plot, height = 200))
    }
    # Unir df con el FECHABtp basado en la columna ProjectCode
    Fecha_btp_df <- data.frame(
      ProjectCode = Fecha_btp$ProjectCode,
      Fecha_btp = Fecha_btp$fechaBtp
    ) 
    # Unir el fechaBt con df
    df <- left_join(df, Fecha_btp_df, by = c("Subcategory" = "ProjectCode"))

    Ventana_btp_df <- data.frame(
      ProjectCode = Ventana_btp$ProjectCode,
      Ventana = Ventana_btp$ventanaBtp
    )
    df <- left_join(df, Ventana_btp_df, by = c("Subcategory" = "ProjectCode"))

    Provincia_df <- data.frame(
      ProjectCode = Provincias$ProjectCode,
      Province = Provincias$Province
    )
    df <- left_join(df, Provincia_df, by = c("Subcategory" = "ProjectCode"))

    eecc_df <- data.frame(
      ProjectCode = Eecc$ProjectCode,
      TEAM = Eecc$eecc
    )
    df <- left_join(df, eecc_df, by = c("Subcategory" = "ProjectCode"))

    extrac_num_ri <- data.frame(
      ProjectCode = Num_RI$ProjectCode,
      NUM_RI = Num_RI$RI_Category
    )
    df <- left_join(df, extrac_num_ri, by = c("Subcategory" = "ProjectCode"))

    # Calcular la cantidad de Subcategories para ajustar el tamaño del gráfico
    num_subcategories <- length(unique(df$Subcategory))
    # Ajusta este valor para determinar espacio entre categorías
    height_plot <- num_subcategories * 20
    # Calcular la suma de los porcentajes por Subcategory y Main_Category
    df_sum <- df %>%
      group_by(Main_Category, Subcategory) %>%
      summarize(
        Suma_Porcentaje = sum(percentage, na.rm = TRUE),
        .groups = "drop"
      )
    # Unir la suma al dataframe original
    df <- left_join(df, df_sum, by = c("Main_Category", "Subcategory"))

    # Ordenar el dataframe según el criterio seleccionado en combo2
    df <- ordenar_dataframe(df, input$combo2)

    # Crear un dataframe con los textos de encabezado
    encabezado <- data.frame(
      Main_Category = rep("REL_DATE", 4),
      Subcategory = rep("PRJ_CODE", 4),
      Caracteristica = c("Classif.", "Design", "WorkOrder", "AppJob"),
      Valor = rep(0, 4),          # Ceros para que no se dibujen puntos
      percentage = rep(0, 4),     # Ceros en porcentaje
      Estado = rep("STATUS", 4),
      Fecha_btp = rep("JOB_DATE", 4),
      Province = rep("PROVINCE", 4),
      TEAM = rep("TEAM", 4),
      NUM_RI = rep("#CRC", 4),
      Ventana = rep("SHIFT", 4),
      Suma_Porcentaje = rep(0, 4)     # Cero en suma porcentaje
    )

    # Aplicar formato idéntico al de tus datos reales (ej: str_pad)
    encabezado <- encabezado %>%
      mutate(
        Main_Category = str_pad(Main_Category, width = 10, side = "both"),
        Subcategory = str_pad(Subcategory, width = 8, side = "both"),
        Estado = str_pad(Estado, width = 9, side = "both"),
        Fecha_btp = str_pad(Fecha_btp, width = 10, side = "both"),
        Province = str_pad(Province, width = 9, side = "both"),
        TEAM = str_pad(TEAM, width = 7, side = "both"),
        NUM_RI = str_pad(NUM_RI, width = 4, side = "both"),
        Ventana = str_pad(Ventana, width = 5, side = "both")
      )
    df <- rbind(df, encabezado)

    #### Generación etiqueta eje Y #####
    ##########################################

    # Crear una nueva columna combinando Main_Category y Subcategory
    df$Main_Category <- substr(df$Main_Category, 1, 10)
    df$Subcategory <- substr(df$Subcategory, 1, 8)
    df$Estado <- substr(df$Estado, 1, 9)
    df$Fecha_btp <- substr(df$Fecha_btp, 1, 10)
    df$Province <- substr(df$Province, 1, 9)
    df$TEAM <- substr(df$TEAM, 1, 7)
    df$NUM_RI <- substr(df$NUM_RI, 1, 4)
    df$Ventana <- substr(df$Ventana, 1, 5)

    # Añadir espacios en blanco a la izquierda para que cada string tenga
    # una longitud fija
    df$Main_Category <- str_pad(df$Main_Category, width = 10, side = "right")
    df$Subcategory <- str_pad(df$Subcategory, width = 8, side = "right")
    df$Estado <- str_pad(df$Estado, width = 9, side = "right")
    df$Fecha_btp <- str_pad(df$Fecha_btp, width = 10, side = "right")
    df$Province <- str_pad(df$Province, width = 9, side = "right")
    df$TEAM <- str_pad(df$TEAM, width = 7, side = "right")
    df$NUM_RI <- str_pad(df$NUM_RI, width = 4, side = "right")
    df$Ventana <- str_pad(df$Ventana, width = 5, side = "right")


    # Crear la nueva columna combinada con el formato deseado
    df$Main_Subcategory <- paste(
      df$Main_Category,
      df$Province,
      df$Subcategory,
      df$NUM_RI,
      df$TEAM,
      df$Estado,
      df$Fecha_btp,
      df$Ventana,
      sep = " - "
    )

    # Convertir la columna 'Subcategory' a factor, para mantener el orden
    df$Subcategory <- factor(
      df$Subcategory,
      levels = rev(unique(df$Subcategory))
    )

    plot <- ggplot(df, aes(x = Caracteristica, y = Main_Subcategory)) +
      # Dibujar bolitas con color según el valor de la característica
      geom_point(
        aes(fill = factor(Valor)),
        shape = 21,
        color = "white",
        size = 8, show.legend = FALSE
      ) +
      scale_fill_manual(values = c("0" = "white",
                                   "1" = "green",
                                   "2" = "yellow")
      ) +
      # Dibujar las líneas horizontales
      geom_segment(aes(x = Caracteristica,
                       xend = Caracteristica,
                       y = Subcategory,
                       yend = Subcategory),
                   # Sólo líneas horizontales
                   color = "gray", linewidth = 0.5, na.rm = TRUE) +
      # Añadir el % en el centro de la bolita (solo si está entre 1 y 99)
      geom_text(
        aes(
          label = ifelse(percentage > 0 & percentage < 100, percentage, "")
        ),
        vjust = 0.5,
        size = 5,
        color = "black"
      ) +
      # Ajustar las etiquetas y el título
      scale_y_discrete(
        limits = rev(unique(df$Main_Subcategory)),
        expand = expansion(mult = 0.003)
      ) +

      # Escalar el eje X con etiquetas en la parte superior e inferior
      scale_x_discrete(
      ) +
      labs(title = NULL) +
      theme_minimal() +
      theme(
        axis.title.x = element_blank(),  # Eliminar el título del eje X
        axis.title.y = element_blank(),  # Eliminar el título del eje Y
        # Rotar las etiquetas del eje X si son largas
        axis.text.x = element_text(
          angle = 0,
          hjust = 0.5,
          size = 12,
          family = "mono"
        ),
        # Alinear etiquetas del eje Y
        axis.text.y = element_text(
          angle = 0,
          hjust = 1,
          size = 12,
          family = "mono",
          margin = margin(r = 10, unit = "pt")
        ),
        # Eliminar las líneas de cuadrícula del eje Y1), "cm")
        panel.grid.major.x = element_blank(),
        plot.margin = margin(10, 30, 10, 10)   # Añadir márgenes
      )
    # Devolver tanto el gráfico como el alto dinámico
    return(list(plot = plot, height = height_plot))
  }

  ##################### 1. PLOT LOLLIPOP (Fin) ##############################
  ###########################################################################
  ################### 2. PLOT Metrics 1 (Inicio) ############################

  dataset_grafico_1 <- function(df_combined) {
    df_combined <- df_combined %>% filter(`Circuit Type` == "RELOCATION")
    # Extraer las fechas únicas de la columna 'Release Date'
    fechas_referencia <- unique(df_combined$`Release Date`)
    # Aplicar filtro de fechas usando función existente filtrar_por_fechas
    df_combined <- filter_by_relaese_dates(df_combined, fechas_referencia)
    # Convierte las fechas en "Job Date" que estén en formato numérico
    df_combined <- df_combined %>%
      mutate(
        `Job Date` = suppressWarnings(
          as.numeric(`Job Date`)
        ),
        # Convertir a fecha si es numérico
        `Job Date` = as.Date(`Job Date`, origin = "1899-12-30")
      )
    # Filtrar ProjectCode replegados
    df_replegados <- df_combined %>%
      filter(
        `Circuit Type` == "RELOCATION" &
          !is.na(`Job Date`) & `Job Date` < Sys.Date()
      )
    # Filtrar ProjectCode que faltan por replagar
    # (Job Date en blanco o texto no interpretable)
    df_faltantes <- df_combined %>%
      filter(
        is.na(`Job Date`) |
          `Job Date` >= Sys.Date() |
          is.character(`Job Date`)
      )
    # Agrupar por 'Release Date' y contar el número de ProjectCode en cada grupo
    df_grafico_1 <- df_combined %>%
      group_by(`Release Date`) %>%
      summarise(
        Total_Replegados = sum(`ProjectCode` %in% df_replegados$ProjectCode),
        Total_Faltantes = sum(`ProjectCode` %in% df_faltantes$ProjectCode)
      ) %>%
      # Agregar columna Tot
      mutate(Total = Total_Replegados + Total_Faltantes) %>% 
      mutate(`Release Date Label` = format(`Release Date`, "%d-%m-%y")) %>%
      arrange(`Release Date`) %>%
      mutate(`Release Date Label` = factor(`Release Date Label`,
        levels = unique(`Release Date Label`)
      )
      )
    return(df_grafico_1)
  }

  generar_grafico_1 <- function(df_grafico_1) {
    ggplot(df_grafico_1, aes(x = `Release Date Label`)) +
      geom_bar(
        aes(
          y = `Total_Faltantes` + `Total_Replegados`,
          fill = "ONGOING"
        ),
        stat = "identity"
      ) +
      geom_bar(
        aes(
          y = `Total_Replegados`,
          fill = "FINISHED"
        ),
        stat = "identity"
      ) +
      geom_text(
        aes(
          y = `Total_Faltantes` + `Total_Replegados`,
          label = ifelse(`Total_Faltantes` == 0, "", `Total_Faltantes`)
        ),
        vjust = 1,
        color = "black"
      ) +
      geom_text(
        aes(
          y = `Total_Faltantes` + `Total_Replegados`,
          label = `Total`
        ),
        vjust = -0.5,
        color = "black",
        fontface = "bold",
        size = 5
      ) +
      labs(
        x = NULL,
        y = NULL,
        fill = NULL,
        title = "GENERAL STATE BY 'RELEASE DATE'"
      ) +
      theme_minimal() +
      theme(
        legend.position = c(0.05, 0.90),
        legend.justification = c(0, 1),
        legend.background = element_rect(fill = "white", color = "black"),
        legend.margin = margin(5, 5, 5, 5),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 14),
        axis.title.x = element_text(size = 20),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
        plot.margin = margin(t = 20, r = 10, b = 10, l = 5)
      ) +
      scale_fill_manual(values = c("FINISHED" = "gray", "ONGOING" = "orange"),
                        breaks = c("ONGOING", "FINISHED")) +
      scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
      coord_cartesian(ylim = c(0, 350))
  }

  ##################### 2. PLOT Metrics 1 (Fin) #############################
  ###########################################################################
  ##################### 3. PLOT Metrics 2 (Inicio) ##########################

  # Función para generar el df y el gráfico con 'Release Date' y 'Semana'
  dataset_grafico_2 <- function(df_combined) {
    ###################################
    ##### Datos comunes (Inicio) ######
    # Obtener la fecha actual
    fecha_actual <- Sys.Date()
    # Calcular la fecha de fin como un mes después de la fecha actual
    fecha_fin <- seq.Date(fecha_actual, by = "2 months", length.out = 2)[2]
    # Generar todas las semanas desde 2022-10-26 hasta 2 meses a partir de hoy
    fecha_inicio <- as.Date("2022-10-24")
    semanas <- seq.Date(fecha_inicio, fecha_fin, by = "week")
    # Crear un dataframe con las semanas
    df_todas_las_semanas <- data.frame(`App_Date` = semanas)
    # Filtrar solo las filas donde 'Circuit Type' sea 'RELOCATION'
    df_combined <- df_combined %>%
      filter(`Circuit Type` == "RELOCATION") %>%
      select(`ProjectCode`, `Release Date`, `Job Date`)
    # Crear la tabla 'df_evolution'
    df_evolution <- df_combined %>%
      select(`Release Date`) %>%
      mutate(`Release Date` = as.Date(`Release Date`, format = "%d-%m-%Y")) %>%
      count(`Release Date`) %>%
      rename(Conteo = n)
    # Crear la matriz de relación
    crear_matriz_relacion <- function(df) {
      fechas <- df$`Release Date`
      n <- length(fechas)
      matriz <- matrix(0, nrow = n, ncol = n)
      for (i in 1:n) {
        matriz[i, i] <- df$Conteo[i]
      }
      matriz_df <- as.data.frame(matriz)
      rownames(matriz_df) <- as.character(fechas)
      colnames(matriz_df) <- as.character(fechas)
      return(matriz_df)
    }
    # Crear la matriz de relación usando df_evolution
    evolution_matrix <- crear_matriz_relacion(df_evolution)
    matrix_to_df <- as.data.frame(evolution_matrix)
    matrix_to_df$App_Date <- rownames(evolution_matrix)
    rownames(matrix_to_df) <- NULL
    matrix_to_df <- matrix_to_df[, c(ncol(matrix_to_df),
                                     1:(ncol(matrix_to_df) - 1))]
    todas_las_semanas <- merge(df_todas_las_semanas,
                               matrix_to_df,
                               by = "App_Date",
                               all.x = TRUE,
                               all.y = TRUE)
    todas_las_semanas[is.na(todas_las_semanas)] <- 0
    # Agregar 'Semana_Anio'
    todas_las_semanas$Semana_Anio <- strftime(todas_las_semanas$App_Date,
                                              format = "%Y-W%U")
    df_unicos <- todas_las_semanas %>%
      group_by(Semana_Anio) %>%
      filter(n() == 1) %>%
      ungroup()
    combinar_filas <- function(df) {
      fila_zeros <- df %>% filter(rowSums(across(where(is.numeric))) == 0)
      fila_valores <- df %>% filter(rowSums(across(where(is.numeric))) > 0)
      if (nrow(fila_zeros) == 1 && nrow(fila_valores) == 1) {
        fila_zeros <- fila_zeros %>%
          mutate(across(where(is.numeric),
                        ~coalesce(fila_valores[[cur_column()]], .)))
      }
      return(fila_zeros)
    }
    columnas_a_evaluar <- setdiff(names(todas_las_semanas),
                                  c("App_Date", "Semana_Anio"))
    df_duplicados_con_valores <- todas_las_semanas %>%
      group_by(Semana_Anio) %>%
      filter(n() > 1) %>%
      group_modify(~ combinar_filas(.)) %>%
      ungroup()
    df_sin_duplicados <- bind_rows(df_unicos, df_duplicados_con_valores) %>%
      arrange(App_Date) %>% 
      select(-Semana_Anio) %>%  
      mutate(across(where(is.numeric), ~na_if(., 0))) %>%
      fill(everything(), .direction = "down") %>%
      mutate(across(where(is.numeric), ~replace_na(., 0)))
    ########### Tabla de movimientos #########
    df_replegado <- df_combined %>%
      select(`Release Date`, `Job Date`) %>%
      mutate(
        `Release Date` = as.Date(`Release Date`, format = "%Y-%m-%d"),
        `Job Date` = suppressWarnings(as.numeric(`Job Date`)),
        `Job Date` = case_when(
          !is.na(`Job Date`) ~ as.Date(`Job Date`,
                                       origin = "1899-12-30"),
          TRUE ~ as.Date(NA)
        )
      ) %>%
      mutate(`Job Date` = case_when(
        `Job Date` > Sys.Date() ~ as.Date(NA),
        TRUE ~ `Job Date`
      ),
      `App_Date` = case_when(
        !is.na(`Job Date`) ~ floor_date(`Job Date`,
                                        unit = "week",
                                        week_start = 1),
        TRUE ~ as.Date(NA)
      )) %>%
      select(-`Job Date`)
    df_por_dia <- df_replegado %>%
      group_by(App_Date, `Release Date`) %>%
      summarise(count = n(), .groups = "drop")
    df_pivot_por_dia <- df_por_dia %>%
      pivot_wider(names_from = `Release Date`,
                  values_from = count,
                  values_fill = 0)
    columnas_fechas <- names(df_pivot_por_dia)[-1]
    fechas_ordenadas <- as.Date(columnas_fechas, format = "%Y-%m-%d")
    columnas_ordenadas <- columnas_fechas[order(fechas_ordenadas)]
    df_pivot_ordenado <- df_pivot_por_dia %>%
      select(App_Date, all_of(columnas_ordenadas)) %>%
      slice(1:(n() - 1))
    df_nueva_tabla <- df_sin_duplicados
    columnas_fechas <- setdiff(names(df_pivot_ordenado), "App_Date")

    ################## PLOT ###################
    calcular_acumulado <- function(columna_a,
                                   columna_b,
                                   fechas_a,
                                   fechas_B) {
      resultado <- columna_a
      acumulado <- 0
      for (i in seq_along(fechas_a)) {
        if (fechas_a[i] %in% fechas_B) {
          indice_b <- which(fechas_B == fechas_a[i])
          acumulado <- acumulado + columna_b[indice_b]
        }
        resultado[i] <- max(columna_a[i] - acumulado, 0)
      }
      return(resultado)
    }
    tabla_grafica_2 <- df_nueva_tabla
    columnas_comunes <- intersect(names(df_nueva_tabla),
                                  names(df_pivot_ordenado))
    columnas_comunes <- columnas_comunes[columnas_comunes != "App_Date"]
    for (col in columnas_comunes) {
      tabla_grafica_2[[col]] <- calcular_acumulado(df_nueva_tabla[[col]],
                                                   df_pivot_ordenado[[col]],
                                                   df_nueva_tabla$App_Date,
                                                   df_pivot_ordenado$App_Date)
    }
    tabla_grafica_2$Total <- rowSums(
      tabla_grafica_2[, -which(names(tabla_grafica_2) == "App_Date")],
      na.rm = TRUE
    )
    tabla_larga <- tabla_grafica_2 %>%
      pivot_longer(
        cols = -App_Date,
        names_to = "Encabezado",
        values_to = "Valor"
      )

    # Mostrar solo desde noviembre de 2023 en adelante excluir valores 0
    tabla_larga_filtrada <- tabla_larga %>%
      filter(App_Date >= as.Date("2023-12-01") & Valor != 0)

    # Asegurarse de que Encabezado sea un factor y mantener el orden
    tabla_larga_filtrada$Encabezado <- factor(tabla_larga_filtrada$Encabezado,
      levels = unique(tabla_larga_filtrada$Encabezado)
    )

    # Crear las etiquetas para la leyenda con formato dia-mes-año
    etiquetas_leyenda <- sapply(
      unique(tabla_larga_filtrada$Encabezado),
      function(x) {
        fecha_convertida <- suppressWarnings(
          as.Date(x, format = "%Y-%m-%d")
        )
        if (!is.na(fecha_convertida)) {
          return(format(fecha_convertida, "%d-%m-%Y"))
        } else {
          return(as.character(x))
        }
      }
    )

    # Asignar nombres para mantener la correspondencia
    names(etiquetas_leyenda) <- levels(tabla_larga_filtrada$Encabezado)
    #retorna tabla_larga_filtrada
    return(list(tabla = tabla_larga_filtrada, etiquetas = etiquetas_leyenda))
  }
  generar_grafico_2 <- function(tabla_larga_filtrada,
                                colores,
                                etiquetas_leyenda) {
    plot <- ggplot(tabla_larga_filtrada, aes(x = App_Date,
                                             y = Valor,
                                             color = Encabezado,
                                             group = Encabezado)) +
      geom_line(linewidth = 1) +
      labs(x = "", y = "", title = "PROJECTS BY 'RELEASE DATE'") +
      scale_color_manual(values = colores,
                         labels = etiquetas_leyenda,
                         guide = guide_legend(ncol = 5)) +
      theme_minimal() +
      theme(
        legend.title = element_blank(),
        legend.position = "bottom",
        legend.text = element_text(size = 12),
        legend.background = element_rect(color = "black",
                                         fill = "white",
                                         linewidth = 0.5,
                                         linetype = "solid"),
        axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16)
      ) +
      scale_x_date(date_labels = "%b-%y", date_breaks = "1 month")
    return(plot)
  }

  ##################### 3. PLOT Metrics 2 (Fin) #############################
  ###########################################################################
  ##################### 4. PLOT Metrics 3 (Inicio) ##########################

  # Función para generar dataset_grafico_3
  dataset_grafico_3 <- function(df_combined) {
    # Filtrar datos donde 'Circuit Type' es 'RELOCATION'
    df_combined <- df_combined %>%
      filter(`Circuit Type` == "RELOCATION") %>%
      select(`ProjectCode`, `Release Date`, `Job Date`)

    # Procesar 'Job Date' para obtener 'App_Date'
    df_replegado <- df_combined %>%
      select(`Release Date`, `Job Date`) %>%
      mutate(
        `Job Date` = suppressWarnings(as.numeric(`Job Date`)),
        `Job Date` = case_when(
          !is.na(`Job Date`) ~ as.Date(`Job Date`,
                                       origin = "1899-12-30"),
          TRUE ~ as.Date(NA)
        ),
        `Job Date` = case_when(
          `Job Date` > Sys.Date() ~ as.Date(NA),
          TRUE ~ `Job Date`
        ),
        `App_Date` = case_when(
          !is.na(`Job Date`) ~ floor_date(`Job Date`,
                                          unit = "week",
                                          week_start = 1),
          TRUE ~ as.Date(NA)
        )
      ) %>%
      select(-`Job Date`)
    # Agrupar por 'App_Date' y sumar 'count' independientemente de 'Release Date'
    df_por_dia_total <- df_replegado %>%
      filter(!is.na(`App_Date`)) %>%
      group_by(App_Date) %>%
      summarise(count = n(), .groups = "drop") %>%
      arrange(App_Date)
    return(df_por_dia_total)
  }

  total_por_replegar <- function(dataframe){
    # Filtrar el DataFrame para conservar únicamente las columnas especificadas
    filtered_df <- dataframe[, c("ProjectCode", "Circuit Type", "Job Date")]

    # Filtrar filas donde 'Circuit Type' sea igual a 'RELOCATION'
    filtered_df <- filtered_df[filtered_df$`Circuit Type` == "RELOCATION", ]

    #Asegurarse de que 'Job Date' es de tipo carácter
    filtered_df$`Job Date` <- as.character(
      filtered_df$`Job Date`
    )

    # Convertir la columna 'Job Date' usando la función definida
    filtered_df$`Job Date` <- sapply(
      filtered_df$`Job Date`,
      convertir_a_fecha
    )

    # Convertir la columna a tipo Date (si la función devuelve cadenas)
    filtered_df$`Job Date` <- as.Date(
      filtered_df$`Job Date`,
      format = "%d-%m-%Y"
    )

    # Obtener la fecha actual
    fecha_actual <- Sys.Date()

    # Establecer a NA las fechas superiores a hoy
    filtered_df$`Job Date`[
      filtered_df$`Job Date` > fecha_actual
    ] <- NA

    # Eliminar filas donde 'ProjectCode' o 'Job Date' son NA
    filtered_df <- filtered_df[complete.cases(filtered_df$ProjectCode,
                                              filtered_df$`Circuit Type`), ]

    # Contar el número de NAs en 'Job Date'
    num_na <- sum(is.na(filtered_df$`Job Date`))
    return(num_na)
  }

  # Cargar el DataFrame (asumiendo que tienes una función load_dataframe en R)
  df_hw <- load_dataframe()

  ################## PLOT ###################

  # Función para generar la gráfica del total de unidades por semana
  generar_grafico_3 <- function(df_por_dia_total, df_original = df_hw) {

    # Definir rango de fechas basado en p2
    fecha_inicio <- min(df_por_dia_total$App_Date, na.rm = TRUE)
    # Proyección de 2 meses
    fecha_fin <- max(df_por_dia_total$App_Date, na.rm = TRUE) + months(2)
    fecha_hoy <- Sys.Date()
    numero_semanas <- as.numeric(difftime(fecha_hoy,
                                          fecha_inicio,
                                          units = "weeks")
    )
    numero_semanas <- floor(numero_semanas)
    # Calcular la suma total de la columna count
    total_count <- sum(df_por_dia_total$count, na.rm = TRUE)
    repliegues_por_semana <- total_count / numero_semanas

    # Llamar a 'total_por_replegar' para obtener 'repliegues_pendientes'
    repliegues_pendientes <- total_por_replegar(df_original)
    # Evitar división por cero
    if (!is.na(repliegues_por_semana) && repliegues_por_semana > 0) {
      # Calcular semanas restantes
      semanas_restantes <- ceiling(
        repliegues_pendientes / repliegues_por_semana
      )
      # Calcular fecha estimada de finalización
      fecha_estimada_fin <- fecha_hoy + weeks(semanas_restantes)
      # Formatear la fecha estimada para mostrar solo mes y año
      fecha_estimada_fin_formateada <- format(fecha_estimada_fin, "%b/%y")
    } else {
      semanas_restantes <- NA
      fecha_estimada_fin_formateada <- "N/A"
    }

    ggplot(df_por_dia_total, aes(x = App_Date, y = count)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      geom_text(aes(label = count), vjust = -0.5, size = 4) +
      labs(
        x = NULL,
        y = NULL,
        title = "NUMBER OF PROJECTS FINISHED PER WEEK"
      ) +
      annotate(
        "text",                           # Tipo de anotación: texto
        x = fecha_fin - 55, 
        y = 9,                            # Ajusta el valor de Y
        label = paste("Media:",
                      round(repliegues_por_semana, 1),
                      "\nFin(est.):",
                      fecha_estimada_fin_formateada), # Texto a mostrar
        size = 5,                         # Tamaño del texto
        color = "red",                    # Color del texto
        hjust = 0,
        fontface = "italic"               # Estilo del texto
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
        plot.margin = margin(t = 30, r = 10, b = 10, l = 10)
      ) +
      scale_x_date(date_labels = "%b-%y",
        date_breaks = "1 month",
        limits = c(fecha_inicio, fecha_fin)
      ) +
      # Ajustar escala del eje Y para que vaya de 1 a 12REPLIEGUES POR SEMANA
      scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, by = 4)
      )
  }

  ##################### 4. PLOT Metrics 3 (Fin) #############################
  ###########################################################################

  # Variable reactiva para almacenar el botón seleccionado
  selected_button <- reactiveVal(NULL)
  # Observador para el botón 2 (lollipop chart)
  observeEvent(input$button2, {
    req(reactive_data$df_combined)
    selected_button("button2")  # Establece que el botón 2 fue presionado
  })
  # Observador para el botón 4 (lollipop chart)
  observeEvent(input$button4, {
    selected_button("button4")  # Establece que el botón 4 fue presionado
  })
  # Definir una variable reactiva para almacenar el valor seleccionado de combo2
  selected_value_2 <- reactiveVal(NULL)
  # Variable reactiva para almacenar el resultado del gráfico y la altura
  selected_plot <- reactive({
    # Asegurarse de que selected_value_2 tiene un valor antes de proceder
    req(selected_value_2())
    # Almacenar el resultado del gráfico y la altura en la variable reactiva
    plot_data <- prepare_data(selected_value_2())
    # Verificar si el plot_data es NULL, lo que indica que no hubo coincidencias
    if (is.null(plot_data)) {
      return(NULL)  # No hay datos para graficar
    }
    # Almacenar el resultado del gráfico y la altura
    plot_lollipop_chart()
  })

  output$canvas <- renderPlot({
    # Verificación inicial obligatoria
    req(reactive_data$df_combined, selected_button())

    # Mostrar información de última actualización
    if (!is.null(reactive_data$last_refresh)) {
      output$last_update <- renderText({
        paste("Última actualización:",
              format(reactive_data$last_refresh, "%Y-%m-%d %H:%M:%S"))
      })
    }

    if (selected_button() == "button2") {
      # Lógica para Ongoing (totalmente reactiva)
      plot_result <- plot_lollipop_chart()

      if (is.null(plot_result)) {
        plot.new()
        text(0.5, 0.5, "No hay datos con los filtros aplicados", cex = 1.5)
      } else {
        plot_result$plot
      }

    } else if (selected_button() == "button4") {
      # Lógica para Metrics (ya está usando react_data$df_combined - perfecto!)
      df_combined <- reactive_data$df_combined

      if (nrow(df_combined) > 0) {
        df_grafico_1 <- dataset_grafico_1(df_combined)
        p1 <- generar_grafico_1(df_grafico_1)

        resultado_dataset <- dataset_grafico_2(df_combined)
        tabla_larga_filtrada <- resultado_dataset$tabla
        etiquetas_leyenda <- resultado_dataset$etiquetas
        colores <- scales::hue_pal()(
          length(levels(tabla_larga_filtrada$Encabezado))
        )
        names(colores) <- levels(tabla_larga_filtrada$Encabezado)

        p2 <- generar_grafico_2(tabla_larga_filtrada,
                                colores,
                                etiquetas_leyenda)
        p3 <- generar_grafico_3(dataset_grafico_3(df_combined))

        grid.arrange(p1, p2, p3, ncol = 1, heights = c(1, 1, 0.5))
      } else {
        plot.new()
        text(0.5, 0.5, "No hay datos disponibles", cex = 2)
      }
    } else {
      # Estado inicial
      plot.new()
      text(0.5, 0.5, "Seleccione una opción", cex = 2)
    }
  }, height = function() {
    if (!is.null(selected_button()) && selected_button() == "button2") {
      ifelse(!is.null(plot_lollipop_chart()$height),
             plot_lollipop_chart()$height,
             300) # Altura por defecto si hay error
    } else {
      1000  # Altura para Metrics
    }
  })

  # Observador para actualizar selected_value_2 al presionar button2 (combo2)
  observeEvent(input$button2, {
    req(reactive_data$df_combined)
    # Actualiza el valor seleccionado de combo2 en selected_value_2
    selected_value_2(input$combo2)
  })
  # Detener la aplicación cuando la sesión finalice
  session$onSessionEnded(function() {
    stopApp()
  })
}

# Ejecuta la aplicación Shiny
shinyApp(ui, server)