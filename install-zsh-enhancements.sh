#!/bin/bash
# Oh-My-Zsh 增强配置安装脚本
# 运行方式: chmod +x install-zsh-enhancements.sh && ./install-zsh-enhancements.sh

echo "🚀 开始安装 oh-my-zsh 增强组件..."

# 检查 oh-my-zsh 是否安装
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "❌ 未检测到 oh-my-zsh，请先安装:"
    echo "   sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    exit 1
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# 1. 安装 Powerlevel10k 主题（推荐）
echo "📦 安装 Powerlevel10k 主题..."
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    echo "✅ Powerlevel10k 安装完成"
    echo "   如需使用，请修改 ~/.zshrc: ZSH_THEME=\"powerlevel10k/powerlevel10k\""
else
    echo "✅ Powerlevel10k 已存在，跳过"
fi

# 2. 安装语法高亮插件
echo "📦 安装 zsh-syntax-highlighting 插件..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "✅ zsh-syntax-highlighting 安装完成"
else
    echo "✅ zsh-syntax-highlighting 已存在，跳过"
fi

# 3. 安装自动建议插件
echo "📦 安装 zsh-autosuggestions 插件..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions 安装完成"
else
    echo "✅ zsh-autosuggestions 已存在，跳过"
fi

# 4. 安装 fzf（命令行模糊查找器）
echo "📦 安装 fzf..."
if ! command -v fzf &> /dev/null; then
    if command -v brew &> /dev/null; then
        brew install fzf
        $(brew --prefix)/opt/fzf/install --all
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
    echo "✅ fzf 安装完成"
else
    echo "✅ fzf 已存在，跳过"
fi

# 5. 安装 bat（带语法高亮的 cat 替代品）
echo "📦 安装 bat..."
if ! command -v bat &> /dev/null; then
    if command -v brew &> /dev/null; then
        brew install bat
        echo "✅ bat 安装完成"
    else
        echo "⚠️  请手动安装 bat: https://github.com/sharkdp/bat"
    fi
else
    echo "✅ bat 已存在，跳过"
fi

# 6. 安装 exa/eza（现代化 ls 替代品）
echo "📦 安装 eza（现代化 ls）..."
if ! command -v eza &> /dev/null; then
    if command -v brew &> /dev/null; then
        brew install eza
        echo "✅ eza 安装完成"
    else
        echo "⚠️  请手动安装 eza: https://github.com/eza-community/eza"
    fi
else
    echo "✅ eza 已存在，跳过"
fi

echo ""
echo "=========================================="
echo "🎉 安装完成！"
echo "=========================================="
echo ""
echo "📋 接下来:"
echo "   1. 重新加载配置: source ~/.zshrc"
echo "   2. 或使用: reload (如果别名已生效)"
echo ""
echo "💡 推荐操作:"
echo "   - 启用 Powerlevel10k 主题（已安装）"
echo "   - 配置 p10k: p10k configure"
echo "   - 尝试使用: z 目录名 快速跳转"
echo "   - 尝试使用: Ctrl+T 用 fzf 查找文件"
echo "   - 尝试使用: Ctrl+R 用 fzf 查找历史"
echo ""
echo "📝 常用快捷键:"
echo "   Tab         - 自动补全"
echo "   Ctrl+T      - fzf 查找文件"
echo "   Ctrl+R      - fzf 查找历史"
echo "   Alt+C       - fzf 进入目录"
echo "   Esc Esc     - 在当前命令前加 sudo"
echo "   Ctrl+G      - 接受自动建议"
echo ""
