import numpy as np
import pandas as pd
import matplotlib.colors as mcolors
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import customtkinter as ctk
from PIL import Image
import sys
import os
from decimal import Decimal

class ctkApp:
    def __init__(self):
        # Basic interface configuration
        ctk.set_appearance_mode("dark")
        self.root = ctk.CTk()
        # Initialize the main application window with dimensions and title
        self.root.geometry("1000x600")
        self.root.title("LIGHTHOUSE")
        # Allow the window to be resizable
        self.root.resizable(width=True, height=True)
        # Configure the grid layout for responsiveness
        self.root.grid_columnconfigure(1, weight=1)
        self.root.grid_rowconfigure(0, weight=1)
        self.root.update()

        self.canvas_widget_id = None

        # Initial setup of the interface
        self.setup_frames()
        self.create_widgets()
        self.bind_events()

        # Main loop of the application
        self.root.mainloop()

    # Function to create the main frames
    def setup_frames(self):
        # Create the left frame with specific dimensions and position
        self.leftframe = ctk.CTkFrame(master=self.root,
                                      height=self.root.winfo_height() * 0.95,
                                      width=self.root.winfo_width() * 0.16)
        # Configure the grid to allocate space for components dynamically
        self.leftframe.grid(row=0, column=0, padx=15, pady=20, sticky="nsw")
        self.leftframe.grid_rowconfigure(3, weight=1)

        # Create the right frame and configure it to be expandable
        self.rightframe = ctk.CTkFrame(master=self.root,
                                       height=self.root.winfo_height() * 0.95,
                                       width=self.root.winfo_width() * 0.84)
        self.rightframe.grid(row=0, column=1, padx=15, pady=20, sticky="nsew")
        self.rightframe.grid_rowconfigure(0, weight=1)
        self.rightframe.grid_columnconfigure(0, weight=1)

    # Function to create the interface widgets
    def create_widgets(self):
        # Add the main label to the left frame
        self.label1 = ctk.CTkLabel(master=self.leftframe,
                                   text='MAIN NODES',
                                   fg_color="transparent",
                                   font=('Calibri',18,'bold'))
        self.label1.grid(row=0, column=0, padx=20, pady=10, sticky="ew")
        # Create a combobox with project options in the left frame
        self.combobox = ctk.CTkComboBox(master=self.leftframe,
                                        values=["NODE_1",
                                                "NODE_2",
                                                "NODE_3",
                                                "NODE_4"])
        self.combobox.grid(row=1, column=0, padx=20, pady=5, sticky="ew")
        # Add a button to the left frame and set its action
        self.button1 = ctk.CTkButton(master=self.leftframe,
                                     command=self.generate_project_overview,
                                     text="Overview")
        self.button1.grid(row=2, column=0, padx=20, pady=5, sticky="ew")
        # Add a canvas to the right frame to serve as a drawing area
        self.canvas = ctk.CTkCanvas(self.rightframe, width=500, height=300)
        self.canvas.grid(row=0, column=0, sticky='nsew')
        
        # Load and display the lighthouse image in the left frame
        resource_dir = getattr(sys, '_MEIPASS', os.path.abspath('.'))
        image_path = os.path.join(resource_dir, 'faro_1.png')
        image = Image.open(image_path)
        self.photo = ctk.CTkImage(dark_image=image, size=(115, 115))
        self.label3 = ctk.CTkLabel(master=self.leftframe, image=self.photo, text='')
        self.label3.grid(row=3, column=0, padx=20, pady=30, sticky="s")

        # Add a scrollbar to the canvas and configure it for vertical scrolling
        self.scrollbar = ctk.CTkScrollbar(self.rightframe,
                                          width=18,
                                          orientation="vertical",
                                          command=self.canvas.yview)
        self.canvas.configure(yscrollcommand=self.scrollbar.set)
        self.scrollbar.grid(row=0, column=1, padx=10, sticky="ns")

        # Añadir Scrollbar horizontal
        self.h_scrollbar = ctk.CTkScrollbar(self.rightframe, 
                                            width=18,
                                            orientation="horizontal", 
                                            command=self.canvas.xview)
        self.canvas.configure(xscrollcommand=self.h_scrollbar.set)
        self.h_scrollbar.grid(row=1, column=0, pady=10, sticky="ew")

    # Generate a heatmap graph based on the selected project
    def generate_project_overview(self):
        try:
            # Get the file path associated with the selected project
            ruta = self.get_selected_project_path()
            # If the path is valid (not None), generate the heatmap graph
            if ruta is not None:
                self.generate_heatmap_graph(ruta)
                self.root.protocol("WM_DELETE_WINDOW", self.cleanup)
        
        except Exception as e:
            self.show_error_message(str(e))

    # Cleans up resources and ensures a graceful shutdown of the application
    def cleanup(self):
        if self.canvas_widget_id is not None:
            # Remove the widget from the canvas
            self.canvas.delete(self.canvas_widget_id)
            # Close all Matplotlib figures to free up memory
            plt.close('all')
        # Destroy the main application window to terminate the program properly
        self.root.destroy()
    
    def get_selected_project_path(self):
        try:
            # Get the selected value from the Combobox
            selected_value = self.combobox.get()
            # Validate that a value has been selected
            if not selected_value:
                self.show_error_message("No se seleccionó ningún proyecto.")
                return None
            # Build the file path
            file_path = os.path.join(os.path.abspath('.'), f"{selected_value}.xlsx")
            # Check if the file exists
            if os.path.exists(file_path):
                return file_path
            else:
                self.show_error_message(
                    f"No se encontró el archivo para el proyecto '{selected_value}'."
                )
                return None
        except Exception as e:
            # Handle unexpected errors
            self.show_error_message(f"Se produjo un error: {str(e)}")
            return None

    # Binds events to the canvas for interactivity
    def bind_events(self):
        # Bind the mouse wheel event to allow vertical scrolling on the canvas
        self.canvas.bind_all(
            '<MouseWheel>', 
            lambda event: self.canvas.yview_scroll(-int(event.delta/60), 'units')
        )
        # Bind the canvas configuration event to adjust its size dynamically when resized
        self.canvas.bind('<Configure>', self.update_size)

    # Extracts and processes data from an Excel file
    def extract_and_process_data(self, selected_value, ruta):
        
        try:
            df = pd.read_excel(ruta, header=1, sheet_name='RI_FO', keep_default_na=False)
           
            # Calculate the number of decimal places in the first value of the 'ID.' column
            if not df.empty:
                first_id = df.iloc[0]['ID.']
                decimals_count = count_decimals(first_id)
            else:
                decimals_count = 0
            
            # Filter the DataFrame based on specific conditions for 'Main_Condition' 
            # and  'ID_Status'
            filtered_df = df[((df['Main_Condition'] == 'Type_1') | (df['Main_Condition'] == 'Type_2')
                            | (df['Main_Condition'] == 'Type_3') | (df['Main_Condition'] == 'Type_4')) & 
                            (df['ID_Status'] != 'Completed')]
            # Create a new DataFrame for processing
            nuevo_df = pd.DataFrame(filtered_df)

            # Function to assign a value to the 'Task_2' column based on complex conditions
            def assign_value_condition_1_and_2(row):
                # Check conditions for 'Main_Condition' and 'Condition_2'
                Main_Condition_is_type_3 = row['Main_Condition'] == 'Type_3' or row['Main_Condition'] == 'Type_4' 
                Condition_2_is_numeric = str(row['Condition_2']).isnumeric()
                Condition_2_is_a_valid_string = isinstance(row['Condition_2'], str) and '*' not in row['Condition_2']
                Condition_2_is_not_empty = row['Condition_2'] != ''
                # Return 1 if any of the conditions are met, otherwise return 0
                if (Main_Condition_is_type_3 or
                    Condition_2_is_numeric or
                    (Condition_2_is_a_valid_string and Condition_2_is_not_empty)):
                    return 1
                else:
                    return 0

            # Define conditions for each task and apply them to create new columns in the DataFrame
            conditions = [
            ('Task_1', lambda row: 0 if row['TASK_1'] == 1 else 1),
            ('Task_2', assign_value_condition_1_and_2),
            ('Task_3', lambda row: 1 if (row['Main_Condition'] == 'Type_1' or 
                                         row['Main_Condition'] == 'Type_2' or
                                         row['Condition_3'] == 1) else 0),
            ('Task_4', lambda row: 1 if str(row['TASK_4']).isnumeric() else 0),
            ('Task_5',
             lambda row: 1 if (
                 row['Main_Condition'] == 'Type_3' or 
                 row['Main_Condition'] == 'Type_4' or 
                 row['TASK_5'] == 1 or 
                 row['TASK_5'] == "1(1)"
             ) else 0
            ),
            ('Task_6', lambda row: 0 if (row['Condition_4'] == 1 and row['Condition_5'] != 1) else 1),
            ('Task_7', lambda row: 0 if (row['Condition_4'] == 1 and row['Condition_6'] != 1) else 1),
            ('Task_8', lambda row: 1 if row['TASK_8'] == 1 else 0),
            ('Task_9', lambda row: 1 if row['TASK_9'] == 1 else 0),
            ('Task_10', 
             lambda row: 1 if (
                 row['Main_Condition'] == 'Type_3' or 
                 row['Main_Condition'] == 'Type_4' or 
                 row['Condition_7'] == 1
             ) else 0
            ),
            ('Task_11', lambda row: 0 if pd.isna(row['TASK_11']) else 1 if row['TASK_11'] else 0),
            ('Task_12', lambda row: 1 if row['TASK_12'] == 1 else 0),
            ('Task_13', lambda row: 0 if row['TASK_13'] == '' else 1),
            ('Task_14', lambda row: 1 if row['TASK_14'] == 1 else 0)
            ]

            # Apply each condition to the DataFrame and add the results as new columns
            for col_name, condition in conditions:
                nuevo_df[col_name] = nuevo_df.apply(condition, axis=1)
            
            # Calculate the sum of all task columns and add it as a new column 'NumerodeDeOk'
            nuevo_df['NumerodeDeOk'] = nuevo_df[['Task_1', 'Task_2','Task_3',
                                                 'Task_4','Task_5','Task_6','Task_7',
                                                 'Task_8','Task_9','Task_10',
                                                 'Task_11','Task_12','Task_13','Task_14']].sum(axis=1)
            
            # Sort the DataFrame by 'DATE_1' in ascending order and 'NumerodeDeOk' in descending order
            nuevo_df.sort_values(by=['DATE_1', 'NumerodeDeOk'], ascending=[True, False], inplace=True)
            # Format the 'DATE_1' column as a date string, replacing invalid dates with an empty string
            nuevo_df['DATE_1'] = (
                pd.to_datetime(nuevo_df['DATE_1'], errors='coerce')
                .dt.strftime('%d-%m-%y')
                .replace('NaT', '')
                .astype(str)
            )
            # Create the final DataFrame with the required columns
            df_nuevo = nuevo_df[['ID.','DATE_1','Task_1', 'Task_2','Task_3',
                                 'Task_4','Task_5','Task_6','Task_7','Task_8','Task_9',
                                 'Task_10','Task_11','Task_12','Task_13','Task_14']]

            return df_nuevo

        except Exception as e:
            raise RuntimeError(f"Error in extract_and_process_data: {str(e)}")

    # Generates a list of y-axis labels from a DataFrame.
    def get_y_labels(self, df_nuevo):
        try:
            decimals_count = 0
            # If the DataFrame is not empty, calculate the number of decimals
            # in the first value of the 'ID.' column
            if not df_nuevo.empty:
                first_id = df_nuevo.iloc[0]['ID.']
                decimals_count = count_decimals(first_id)

            # Apply a lambda function to create labels for each row
            y_labels = df_nuevo.apply(
                lambda row: (
                    # Format the ID with the calculated decimals count and add the date
                    format_id(row['ID.'], decimals_count) + " - " + row['DATE_1']
                    # Include the date if it is not null
                    if pd.notna(row['DATE_1'])
                    # Otherwise, only the ID
                    else format_id(row['ID.'], decimals_count)
                ), 
                axis=1
            ).tolist()
            # Return the generated list of labels  
            return y_labels

        except Exception as e:
            raise RuntimeError(f"Error in get_y_labels: {str(e)}")






    def generate_heatmap_graph(self, ruta):
        try:
            # Limpia el contenido existente en el canvas
            if self.canvas_widget_id is not None:
                self.canvas.delete(self.canvas_widget_id)

            # Obtiene el valor seleccionado del Combobox
            selected_value = self.combobox.get()

            # Extrae y procesa datos
            df_nuevo = self.extract_and_process_data(selected_value, ruta)
            y_labels = self.get_y_labels(df_nuevo)
            x_labels = df_nuevo.columns[2:].tolist()
            
            # Quita la columna 'DATE_1' antes de crear el heatmap
            df_nuevo_without_dates = df_nuevo.drop(columns=['DATE_1'])
            df3 = df_nuevo_without_dates.set_index('ID.')

            # Número de filas y columnas
            num_rows = len(y_labels)
            num_cols = len(x_labels)

            # Tamaño de celda deseado (en pulgadas)
            cell_width = 0.5
            cell_height = 0.5

            # Calculamos figsize en función del número de filas y columnas
            figsize_width = cell_width * num_cols
            figsize_height = cell_height * num_rows

            # Definir DPI fijo para mantener coherencia entre pulgadas y píxeles
            dpi = 100

            # Crear la figura con el figsize calculado
            fig, ax = plt.subplots(figsize=(figsize_width, figsize_height), dpi=dpi)

            # Ajustar márgenes para dejar espacio a etiquetas sin comprimir las celdas.
            # Estos valores son orientativos; puedes ajustarlos según sea necesario.
            fig.subplots_adjust(left=0.3, bottom=0.1, right=0.95, top=0.95)

            # Establecer aspecto igual para que las celdas sean cuadradas
            ax.set_aspect("equal")

            # Crear la cuadricula (pcolormesh) con el colormap definido
            green_color = "#27D3A8"
            red_color = "#F8E7AE"
            colors = [red_color, green_color]
            cmap = mcolors.ListedColormap(colors)

            # Crear las coordenadas de la malla
            Circuit, Task = np.mgrid[:df3.shape[0]+1, :df3.shape[1]+1]

            plt.pcolormesh(
                Task, Circuit, df3.values, cmap=cmap, edgecolor="w", 
                vmin=0, vmax=1, alpha=0.8, linewidth=0.5
            )

            # Configurar las etiquetas del eje X e Y
            plt.xticks(
                np.arange(1, len(x_labels) + 1) - 0.5, 
                x_labels, 
                rotation=90, 
                ha='center'
            )

            plt.yticks(
                np.arange(1, len(y_labels) + 1) - 0.5, 
                y_labels, 
                ha='right'
            )

            plt.xlim(0, len(x_labels))
            plt.ylim(0, len(y_labels))

            # Crear eje secundario arriba con mismas etiquetas
            ax_top = ax.secondary_xaxis('top')
            ax_top.set_xticks(np.arange(1, len(x_labels) + 1) - 0.5)
            ax_top.set_xticklabels(x_labels, rotation=90)

            # Convertir la figura de Matplotlib en un widget de Tkinter
            self.canvas_widget = FigureCanvasTkAgg(fig, master=self.canvas)
            
            # Calcular el tamaño en pixeles
            pixel_width = int(figsize_width * dpi)
            pixel_height = int(figsize_height * dpi)

            # Crear ventana en el canvas con el ancho y alto calculados
            self.canvas_widget_id = self.canvas.create_window(
                0, 0,
                window=self.canvas_widget.get_tk_widget(),
                anchor='nw',
                width=pixel_width,
                height=pixel_height
            )

            self.canvas_widget.draw()

            # Ajustar el scrollregion del canvas para que abarque toda la figura
            self.canvas.config(scrollregion=(0, 0, pixel_width, pixel_height))

            plt.close(fig)  # Cerrar la figura para liberar recursos

        except Exception as e:
            self.show_error_message(str(e))
















    # Generates a heatmap graph based on the processed data from the provided file path
    def generate_heatmap_graph_1(self, ruta):

        try:
            # Clear existing content in the canvas
            self.canvas.delete(self.canvas_widget_id)

            # Get the selected value from the Combobox
            selected_value = self.combobox.get()
            # Extract and process the data from the provided file path
            df_nuevo = self.extract_and_process_data(selected_value, ruta)
            # Generate labels for the Y-axis
            y_labels = self.get_y_labels(df_nuevo)          
            # Get the column names starting from the third column as X-axis labels
            x_labels = df_nuevo.columns[2:].tolist()
            # Remove the 'DATE_1' column from the DataFrame before creating the heatmap
            df_nuevo_without_dates = df_nuevo.drop(columns=['DATE_1'])
            # Reshape the data and prepare the grid for plotting
            df3 = df_nuevo_without_dates.set_index('ID.')
            Circuit, Task = np.mgrid[:df3.shape[0]+1, :df3.shape[1]+1]





            # Calculate the graph size based on screen dimensions and data points
            #min_graph_width = 50  # Ensure the graph is always visible
            # Limit width by the canvas size
            #max_graph_width = self.canvas.winfo_width()
            #graph_width = max(min_graph_width, max_graph_width)
            # Ensure a minimum height for visibility
            #min_graph_height = 200
            # Limit height by screen size
            #max_graph_height = self.root.winfo_screenheight()
            # Limit the graph height to the screen size
            #graph_height = max(min_graph_height, max_graph_height)
            # Define the figure size for Matplotlib (The width is proportional to 
            # the canvas width, and the height is proportional to the graph height)
            #figsize = (graph_width/45, graph_height/45)
            # Create a Matplotlib figure and axis
            #fig, ax = plt.subplots(figsize=figsize)
            
            
            
            
            # Establecer tamaño fijo de celda en pulgadas
            cell_width = 0.6  # en pulgadas
            cell_height = 0.6  # en pulgadas

            # Calcular el tamaño de la figura basado en el número de columnas y filas
            figsize_width = cell_width * len(x_labels)
            figsize_height = cell_height * len(y_labels)

            # Opcionalmente, limitar el tamaño máximo de la figura
            max_figsize_width = self.root.winfo_screenwidth() / self.root.winfo_fpixels('1i')  # en pulgadas
            max_figsize_height = self.root.winfo_screenheight() / self.root.winfo_fpixels('1i')  # en pulgadas

            figsize_width = min(figsize_width, max_figsize_width)
            figsize_height = min(figsize_height, max_figsize_height)

            # Crear una figura y eje de Matplotlib
            fig, ax = plt.subplots(figsize=(figsize_width, figsize_height))
            print(f"Figura generada: ancho = {figsize_width:.2f} pulgadas, alto = {figsize_height:.2f} pulgadas")
            
            
            
            
            
            
            
            
            # Set the aspect ratio to "equal" to ensure all squares are the same size
            ax.set_aspect("equal")  



            # Ajustar los márgenes de la figura para reducir el espacio blanco en el lado derecho
            #fig.subplots_adjust(left=0.05, right=0.95, top=0.95, bottom=0.05)





            # Custom colors for the heatmap
            green_color = "#27D3A8"
            red_color = "#F8E7AE"
            colors = [red_color, green_color]
            cmap = mcolors.ListedColormap(colors)
            
            # Set a constant cell size for the heatmap
            cell_size = 0.5  
            plt.pcolormesh(
                Task, Circuit, df3.values, cmap=cmap, edgecolor="w", 
                vmin=0, vmax=1, alpha=0.8, linewidth=cell_size
            )
            # Configure the X-axis ticks and labels
            plt.xticks(
                np.arange(1, len(x_labels) + 1) - 0.5, 
                x_labels, 
                rotation='vertical', 
                ha='center'
            )
            # Configure the Y-axis ticks and labels
            plt.yticks(
                np.arange(1, len(y_labels) + 1) - 0.5, 
                y_labels, 
                ha='right'
            )
            # Set the limits for X and Y axes
            plt.xlim(0, len(x_labels))
            plt.ylim(0, len(y_labels))

            # Add a secondary X-axis at the top with the same labels as the bottom X-axis
            ax_top = ax.secondary_xaxis('top')

            ax_top.set_xticks(np.arange(1, len(x_labels) + 1) - 0.5)
            ax_top.set_xticklabels(x_labels, rotation=90)
            
            # Integrate the Matplotlib figure with the Tkinter canvas
            self.canvas_widget = FigureCanvasTkAgg(fig, master=self.canvas)
            self.canvas_widget_id = self.canvas.create_window(
                self.canvas.winfo_width() / 2,      # Center the graph horizontally
                self.canvas.winfo_height() / 2,     # Center the graph vertically
                window=self.canvas_widget.get_tk_widget(),
                width=self.canvas.winfo_width(),    # Match the width to the canvas width
                anchor='s'                          # Anchor the graph to the bottom center
            )
            self.canvas_widget.draw()       # Render the graph on the canvas



            # Al final de generate_heatmap_graph, luego de self.canvas_widget.draw():
            #self.canvas.update_idletasks()
            #self.canvas.config(scrollregion=self.canvas.bbox('all'))


            # Fuerza el renderizado de la figura para que se puedan calcular las posiciones reales
            fig.canvas.draw()

            # Ahora podemos obtener el tamaño del área del eje y de las etiquetas
            # Área del eje (sin las etiquetas):
            # ax.get_position() devuelve un Bbox en coordenadas normalizadas [0,1]
            pos = ax.get_position()
            fig_width_inch, fig_height_inch = fig.get_size_inches()
            dpi = fig.dpi

            # Dimensiones del área del eje en pulgadas:
            axes_area_width_inch = pos.width * fig_width_inch
            axes_area_height_inch = pos.height * fig_height_inch

            # Obtener las etiquetas del eje Y
            y_ticklabels = ax.get_yticklabels()

            if y_ticklabels:
                # Obtener la extensión en pixeles de cada etiqueta
                ticklabel_extents = [label.get_window_extent(renderer=fig.canvas.get_renderer()) for label in y_ticklabels]

                # Calcular el bounding box total que cubre todas las etiquetas Y
                xmins = [bbox.x0 for bbox in ticklabel_extents]
                xmaxs = [bbox.x1 for bbox in ticklabel_extents]
                ymins = [bbox.y0 for bbox in ticklabel_extents]
                ymaxs = [bbox.y1 for bbox in ticklabel_extents]

                min_x = min(xmins)
                max_x = max(xmaxs)
                min_y = min(ymins)
                max_y = max(ymaxs)

                # Convertir pixeles a pulgadas dividiendo por dpi
                ticklabels_width_inch = (max_x - min_x) / dpi
                ticklabels_height_inch = (max_y - min_y) / dpi
            else:
                ticklabels_width_inch = 0
                ticklabels_height_inch = 0

            # Imprimir en consola o mostrar en interfaz
            print(f"Área del eje (sólo cuadrícula): {axes_area_width_inch:.2f} x {axes_area_height_inch:.2f} pulgadas")
            print(f"Área total de las etiquetas Y: {ticklabels_width_inch:.2f} x {ticklabels_height_inch:.2f} pulgadas")

            # Opcional: mostrar en la interfaz, por ejemplo en una etiqueta:
            size_label = ctk.CTkLabel(
                master=self.canvas,
                text=(
                    f"Área del eje: {axes_area_width_inch:.2f}x{axes_area_height_inch:.2f} pulgadas\n"
                    f"Etiquetas Y: {ticklabels_width_inch:.2f}x{ticklabels_height_inch:.2f} pulgadas"
                ),
                fg_color="transparent"
            )
            size_label.grid(row=5, column=0, padx=20, pady=10, sticky="ew")






            plt.close(fig)                  # Close the figure to free resources

        except Exception as e:
            self.show_error_message(str(e))

    # Updates the size and position of the canvas widget when the canvas is resized
    def update_size(self, event):
        if self.canvas_widget_id is not None:
            # Get the updated width and height of the canvas
            canvas_width = event.width
            # Retrieve current canvas height
            canvas_height = self.canvas.winfo_height()

            # Update the position of the canvas widget (centered in the canvas)
            self.canvas.coords(self.canvas_widget_id, canvas_width / 2, canvas_height / 2)
            # Adjust the width of the canvas item to match the new canvas width
            self.canvas.itemconfig(self.canvas_widget_id, width=canvas_width)
            # Update the scrollable region to match the new canvas bounding box
            self.canvas.config(scrollregion=self.canvas.bbox('all'))
            # Schedule a canvas update to refresh after 100 milliseconds
            self.root.after(100, self.update_canvas)

    # Refreshes the canvas to redraw its contents.
    def update_canvas(self):
        self.canvas_widget.draw()

    # Displays an error message on the canvas
    def show_error_message(self, error_message):
        # Create a label with the error message in red
        error_label = ctk.CTkLabel(
            master=self.canvas,
            text=f'Error: {error_message}',
            fg_color="red"
        )
        # Place the error label on the canvas
        error_label.grid(row=4, column=0, padx=20, pady=10, sticky="ew")
        # Force the root window to refresh and display the error message
        self.root.update()
        # Automatically remove the error message after 5 seconds
        self.root.after(5000, error_label.destroy)  # Elimina el mensaje de error después de 3000 milisegundos (3 segundos)

# Determines the number of decimal places in a given number
def count_decimals(number):
    if isinstance(number, float):
        # Convert the number to a Decimal object to accurately count decimals
        decimal_number = Decimal(str(number))
        # Extract and return the number of decimal places
        return abs(decimal_number.as_tuple().exponent)
    return 0        # Return 0 if the input is not a float

# Formats the 'ID.' field value with a specific number of decimal places
def format_id(id_value, decimals_count):
    if isinstance(id_value, (int, float)):
        # Format the number with the specified number of decimal places
        return "{:.{}f}".format(id_value, decimals_count)
    elif isinstance(id_value, str):
        # Return the string as-is if the value is already a string
        return id_value
    else:
        # Convert other types to string for consistent output
        return str(id_value)

if __name__ == "__main__":
    CTK_Window = ctkApp()

