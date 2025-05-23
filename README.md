🚗 egl_wheel // ESX & QBCore Compatible Wheel Repair & Replacement Script

This script brings a more immersive vehicle maintenance experience to your FiveM server by allowing players to inspect, repair, and swap out tires using consumable items. Compatible with both ESX and QBCore, it leverages ox_target (or qb-target) for precise interaction zones and ox_lib’s progress bars (or your preferred alternative).

# 🌟 Features

    Realistic Wheel Inspection & Repair: Players can check individual tire conditions and repair punctures using a configurable repair kit item.
    Spare Tire Replacement: If a tire is beyond repair, they can remove it and fit a spare tire from their inventory.
    ESX & QBCore Compatibility: Works out-of-the-box with ESX (es_extended) or QBCore (qb-core), detected via config.Core.
    Target System Integration: Supports both ox_target and qb-target, selectable in config.Target, for smooth in-world interaction spheres.
    Flexible Progress Bars: Uses ox_lib (via config.progressBar) for asynchronous progress feedback; easily swap to another progress bar resource.
    Configurable Items & Localization: Define your own repair kit and spare tire item names in config.lua. Supports French (fr) or English (en) locales.
    Performance-Oriented Design: Efficient distance checks, native caching, and dynamic zone creation minimize CPU overhead.

# 🛠 Installation

    Download the release last version.
    Place the script in your server's resources folder.
    Add start egl_wheel to your server.cfg file.
    Configure the script by editing config.lua to match your item names, target/progress integrations, and core framework.

# 📦 Dependencies

    Framework: ESX (es_extended) or QBCore (qb-core)
    Target System: ox_target or qb-target
    Progress Bar: ox_lib or your preferred progress bar resource
    Optional: ox_lib/init.lua for shared utilities (if using ox_lib) | Must be mentioned in fxmanifest.lua

# ⚙️ Configuration

All settings live in config.lua:

    Locales: Choose your language (fr for French, en for English).
    Core: Select your server framework.
    Target: Pick your interaction zone resource.
    Progress Bar: Define which progress bar script to call.
    Item Names: Match these to your inventory items.

# 🤝 Contribution

Contributions are welcome! If you have ideas for new features, compatibility enhancements, or bug fixes, please create a pull request.

# 📄 License

This project is licensed under the MIT License. For more details, refer to the LICENSE file.

# 📞 Support and Contact

For issues or questions, please open an issue on this GitHub repository or join my Discord community server: https://discord.gg/BCaP4CtJpP or reach out directly to me: 0xeagle1337.
