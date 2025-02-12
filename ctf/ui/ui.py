import gi
import os
import signal
import subprocess

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

gi.require_version('Vte', '2.91')
from gi.repository import Vte, Gdk

signal.signal(signal.SIGINT, signal.SIG_DFL)

script_dir = os.path.dirname(os.path.abspath(__file__))


def set_dark_theme():
    Gtk.Settings.get_default().set_property("gtk-theme-name", "Adwaita-dark")


textos = {
    "es": {
        "entrar": "Entrar al reto",
        "reto" : "Imprimir reto",
        "restart" : "Reiniciar retos"
    },
    "en": {
        "entrar": "Enter challenge",
        "reto" : "Show challenge",
        "restart" : "Restart challenges"
    },
    "gl": {
        "entrar": "Entrar ao reto",
        "reto" : "Imprimir reto",
        "restart" : "Reiniciar retos"
    }
}

lang_file = os.path.join(script_dir, "/etc/ctf_var/", "LANG")

def load_language():
    if os.path.exists(lang_file):
        with open(lang_file, 'r') as file:
            language = file.read().strip()
        return language
    else:
        lang_command = f"echo 'gl' > /etc/ctf_var/LANG"
        subprocess.run(lang_command, shell=True, check=True, capture_output=True, text=True)
        return "gl"

current_language = load_language()


def show_about_dialog(button):
    about_dialog = Gtk.AboutDialog()
    about_dialog.set_program_name("Linux CTF ARQPYB")
    about_dialog.set_version("Open BETA")
    about_dialog.set_copyright("© 2025 Chuten")
    about_dialog.set_comments("Unha ferramenta para facer máis doada a aprendizaxe de comandos Linux.")
    about_dialog.set_license(
        "Copyright (c) 2025 Chuten\n\n"
        "Permission is hereby granted, free of charge, to any person obtaining a copy\n"
        "of this software and associated documentation files (the \"Software\"), to deal\n"
        "in the Software without restriction, including without limitation the rights\n"
        "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n"
        "copies of the Software, subject to the following conditions:\n\n"
        "1. This software may not be used for commercial purposes.\n\n"
        "2. Redistributions of the Software, modified or unmodified, must retain the above\n"
        "   copyright notice, this list of conditions, and the following disclaimers.\n\n"
        "3. Any derivative works must prominently indicate that they are derived from this Software.\n\n"
        "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
        "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
        "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n"
        "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
        "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n"
        "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n"
        "THE SOFTWARE."
    )
    logo_path = os.path.join(script_dir, "img/logo32x32.png")
    if os.path.exists(logo_path):
        image = Gtk.Image()
        image.set_from_file(logo_path)
        about_dialog.set_logo_icon_name(None)
        about_dialog.set_logo(image.get_pixbuf())
    about_dialog.set_website("https://github.com/FranciscoFuentesRamos/Linux_CTF_ARQPYB?tab=readme-ov-file")  # Cambia por tu URL
    about_dialog.set_website_label("Visita o repositorio")
    about_dialog.set_transient_for(win) 
    about_dialog.run()
    about_dialog.destroy()

def set_textos(language):
    global current_language
    current_language = language
    button_entrar.set_label(textos[language]["entrar"])
    button_reto.set_label(textos[language]["reto"])
    button_restart.set_label(textos[language]["restart"])
    lang_command = f"echo '{language}' > /etc/ctf_var/LANG"
    subprocess.run(lang_command, shell=True, check=True, capture_output=True, text=True)

    


    
def on_button_click(button, action):

    reto_number = f"{int(spin_button.get_value()):02}"
    
    if action == "entrar":   
        login_command = f"\nsu - Reto{reto_number}\n"
        term.feed_child(login_command.encode())
        

set_dark_theme()
# Crear ventana principal
win = Gtk.Window()
win.set_title('Linux CTF ARQPYB')
win.set_default_size(1200, 800)
win.set_resizable(True)
win.connect('delete-event', Gtk.main_quit)

icon_path = os.path.join(script_dir, "img/logo.png")
if os.path.exists(icon_path):
    win.set_icon_from_file(icon_path)
else:
    print(f"Advertencia: El ícono no se encontró en la ruta {icon_path}")

header_bar = Gtk.HeaderBar()
header_bar.set_show_close_button(True)

combo_box = Gtk.ComboBoxText()
combo_box.append("es", "Español")
combo_box.append("en", "English")
combo_box.append("gl", "Galego")

initial_language = load_language()
combo_box.set_active({"es": 0, "en": 1, "gl": 2}.get(initial_language, 2))
combo_box.connect("changed", lambda combo: set_textos(combo.get_active_id()))
header_bar.pack_start(combo_box)
win.set_titlebar(header_bar)

# Botón About
button_about = Gtk.Button(label="About")
button_about.connect("clicked", show_about_dialog)
header_bar.pack_end(button_about)  # Añadir botón About al lado derecho de la barra
win.set_titlebar(header_bar)
# Crear un contenedor Box horizontal
container = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=0)

# Crear contenedor principal para el menú
menu_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
menu_box.set_margin_top(10)
menu_box.set_margin_bottom(10)
menu_box.set_margin_start(10)
menu_box.set_margin_end(10)



# Crear una cuadrícula para los botones
button_grid = Gtk.Grid()
button_grid.set_row_spacing(10)
button_grid.set_column_spacing(10)
button_grid.set_margin_top(10)
button_grid.set_margin_bottom(10)
button_grid.set_margin_start(10)
button_grid.set_margin_end(10)

image = Gtk.Image()
image.set_from_file(os.path.join(script_dir, "img/logo128x128.png"))
button_grid.attach(image, 0, 0, 2, 1) 



# Crear botones para el menú

button_entrar = Gtk.Button(label=textos[current_language]["entrar"])
button_entrar.connect("clicked", on_button_click, "entrar")  
button_grid.attach(button_entrar,  0, 1, 1, 1)

adjustment = Gtk.Adjustment(lower=0, upper=99, step_increment=1, page_increment=10, page_size=0)
spin_button = Gtk.SpinButton(adjustment=adjustment, climb_rate=1, digits=0)
spin_button.set_value(0) 
spin_button.set_wrap(True) 
button_grid.attach(spin_button, 1, 1, 1, 1)

separator1 = Gtk.Separator(orientation=Gtk.Orientation.HORIZONTAL)
button_grid.attach(separator1, 0, 3, 2, 1)

button_reto = Gtk.Button(label=textos[current_language]["reto"])
button_reto.connect("clicked", lambda btn: term.feed_child(b"reto\n"))  # Enviar comando 'reto' a la terminal
button_grid.attach(button_reto, 0, 4, 2, 1)  # Ocupa toda la fila (2 columnas)

button_restart = Gtk.Button(label=textos[current_language]["restart"])
button_restart.connect("clicked", lambda btn: term.feed_child(b"restart\n"))  # Enviar comando 'restart' a la terminal
button_grid.attach(button_restart, 0, 5, 2, 1)  # Ocupa toda la fila (2 columnas)

# Añadir el Grid con los botones y la imagen al menu_box
menu_box.pack_start(button_grid, True, True, 0)

# Crear la terminal
term = Vte.Terminal()

# Configurar el color de la terminal
def set_tango_palette():
    colors = {
        "background": Gdk.RGBA(red=0.1, green=0.1, blue=0.1, alpha=1.0),  # #2E3436
        "foreground": Gdk.RGBA(red=0.86, green=0.84, blue=0.8, alpha=1.0),  # #DCDCCC
        "color0": Gdk.RGBA(red=0.8, green=0.0, blue=0.0, alpha=1.0),  # Rojo (#CC0000)
        "color1": Gdk.RGBA(red=0.77, green=0.63, blue=0.0, alpha=1.0),  # Amarillo (#C4A000)
        "color2": Gdk.RGBA(red=0.3, green=0.6, blue=0.02, alpha=1.0),  # Verde (#4E9A06)
        "color3": Gdk.RGBA(red=0.46, green=0.31, blue=0.48, alpha=1.0),  # Magenta (#75507B)
        "color4": Gdk.RGBA(red=0.2, green=0.41, blue=0.64, alpha=1.0),  # Azul (#3465A4)
        "color5": Gdk.RGBA(red=0.65, green=0.40, blue=0.70, alpha=1.0),  # Magenta (#06989A)
        "color6": Gdk.RGBA(red=0.83, green=0.84, blue=0.8, alpha=1.0),  # Blanco (#D3D7CF)
    }

    # Establecer colores
    term.set_colors(colors["foreground"], colors["background"], 
                    [colors["color0"], colors["color1"], colors["color2"], colors["color3"],
                     colors["color4"], colors["color5"], colors["color6"], colors["color0"],
                     colors["color1"], colors["color2"], colors["color3"], colors["color4"],
                     colors["color5"], colors["color6"], colors["color0"], colors["color1"]])

set_tango_palette()

# Habilitar Copiar/Pegar desde portapapeles
def on_key_press(widget, event):
    keyval = event.keyval
    state = event.state

    if keyval == Gdk.KEY_C and state & Gdk.ModifierType.CONTROL_MASK and state & Gdk.ModifierType.SHIFT_MASK:
        term.copy_clipboard()
        return True
    elif keyval == Gdk.KEY_V and state & Gdk.ModifierType.CONTROL_MASK and state & Gdk.ModifierType.SHIFT_MASK:
        term.paste_clipboard()
        return True
    return False
term.connect("key-press-event", on_key_press)

# Inicializar el terminal con un shell bash
rtn = term.spawn_sync(
    Vte.PtyFlags.DEFAULT,
    None,
    # Ejecutar como root
    #['/bin/bash'], 
    ['/bin/bash', '-c', 'su - Reto00; exec bash'], 
    [],
    GLib.SpawnFlags.DO_NOT_REAP_CHILD,
    None,
    None,
)

# Mostrar todo
term.show_all()

container.pack_start(menu_box, False, False, 0)  # Menú ocupa espacio fijo
container.pack_start(term, True, True, 0)  # Terminal ocupa el espacio restante

# Añadir el contenedor a la ventana
win.add(container)
win.show_all()
Gtk.main()
