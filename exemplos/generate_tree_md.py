import os
import datetime
import sys
import io # Import the io module

# Set stdout encoding to UTF-8
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 🔧 Feature toggles
INCLUDE_EMOJI = True
INCLUDE_METADATA = False
INCLUDE_COMMENTS = True
SMART_FOLDER_LABELS = False

# 🗒️ Manual file comments (extend as needed)
MANUAL_COMMENTS = {
    "WebBrowser.js": "Main browser component",
    "WebBrowser.module.css": "Browser styles",
    "BrowserExamples.js": "Example components (optional)",
    "README.md": "Project overview",
    "config.json": "Configuration settings"
}

# 🎭 Emoji mapping by file extension
def emoji_for_file(file_name):
    ext = os.path.splitext(file_name)[1].lower()
    return {
        '.js': '📜',
        '.ts': '📘',
        '.css': '🎨',
        '.scss': '🧵',
        '.html': '🌐',
        '.py': '🐍',
        '.md': '📝',
        '.json': '🔧',
        '.jpg': '🖼️',
        '.png': '🖼️',
        '.txt': '📄',
        '.lock': '🔒',
        '.m': '📊',    # MATLAB/Objective-C
        '.bat': '⚙️',  # Batch scripts
        '.psimsch': '💻', # PSIM (assuming a general software/simulation icon)
        '.xml': '📋',  # XML files
    }.get(ext, '📄')

# 📂 Emoji by folder purpose
def emoji_for_folder(folder_name):
    mapping = {
        'test': '🧪',
        'tests': '🧪',
        'components': '🧩',
        'config': '⚙️',
        'public': '🌐',
        'docs': '📚',
        'scripts': '📜',
        'assets': '🎨',
        'utils': '🧰',
    }
    for key, icon in mapping.items():
        if key.lower() in folder_name.lower():
            return icon
    return '📂'

# 📊 Generate metadata comment
def get_file_metadata_comment(file_path):
    stats = os.stat(file_path)
    size_kb = stats.st_size / 1024
    mtime = datetime.datetime.fromtimestamp(stats.st_mtime)
    ext = os.path.splitext(file_path)[1].lower().lstrip('.').upper() or "Unknown"
    return f"{ext} file, {size_kb:.1f} KB, modified {mtime.strftime('%Y-%m-%d %H:%M')}"

# 🌳 Recursive folder walker
def map_folder_structure(root_path, indent=""):
    lines = []
    items = sorted(os.listdir(root_path))
    for idx, item in enumerate(items):
        item_path = os.path.join(root_path, item)
        is_last = idx == len(items) - 1
        prefix = "└── " if is_last else "├── "
        line_prefix = indent + prefix
        # Folder line
        if os.path.isdir(item_path):
            folder_emoji = emoji_for_folder(item) if SMART_FOLDER_LABELS and INCLUDE_EMOJI else ('📁' if INCLUDE_EMOJI else '')
            spacing = ' ' if INCLUDE_EMOJI else ''
            line = f"{line_prefix}{folder_emoji}{spacing}{item}/"
            lines.append(line)
            new_indent = indent + ("    " if is_last else "│   ")
            lines.extend(map_folder_structure(item_path, new_indent))
        # File line
        else:
            file_emoji = emoji_for_file(item) if INCLUDE_EMOJI else ''
            spacing = ' ' if INCLUDE_EMOJI else ''
            comments = []

            if INCLUDE_COMMENTS and item in MANUAL_COMMENTS:
                comments.append(MANUAL_COMMENTS[item])
            if INCLUDE_METADATA:
                comments.append(get_file_metadata_comment(item_path))

            comment_str = f"  # {' | '.join(comments)}" if comments else ''
            line = f"{line_prefix}{file_emoji}{spacing}{item}{comment_str}"
            lines.append(line)

    return lines

# 🧪 Wrap it all for Markdown embedding
def generate_docusaurus_bash_block(root_path):
    root_name = os.path.basename(os.path.abspath(root_path))

    if SMART_FOLDER_LABELS and INCLUDE_EMOJI:
        top_icon = emoji_for_folder(root_name)
    elif INCLUDE_EMOJI:
        top_icon = '📂'
    else:
        top_icon = ''

    spacing = ' ' if INCLUDE_EMOJI else ''
    lines = [f"{top_icon}{spacing}{root_name}/"]
    lines.extend(map_folder_structure(root_path))
    return "```bash\n" + "\n".join(lines) + "\n```"

# ▶️ Main execution block
if __name__ == "__main__":
    if len(sys.argv) > 1:
        # Get the root_path from the first command-line argument
        input_root_path = sys.argv[1]
    else:
        # Default path if no argument is provided (e.g., for direct execution)
        input_root_path = "PSIM"

    output = generate_docusaurus_bash_block(input_root_path)
    print(output)

    with open("project-structure.md", "w", encoding="utf-8") as f:
        f.write("## 📂 Project Structure\n\n")
        f.write(output)