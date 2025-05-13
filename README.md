# 📱 Mi Fortitú

Mi Fortitú started as a personal project to continue my specialization in mobile app development, following the 42 methodology. While initially created for my own learning, it is now an open, community-driven project designed for 42 students and anyone interested in contributing, learning, and building together. Built with Flutter, it connects with the official 42 API and offers enriched, gamified experiences for students across various campuses.

⚠️ **Early access only**: As the project is in early testing, access is limited to a small group of approved users to avoid exceeding API usage limits.

---

## 📱 Download the APK

👉 [Latest APK release](https://drive.google.com/file/d/13Dlou0RSkJuNnef0CyEYTRo-cwQvZ9fE/view?usp=drive_link)
🕘 **Version:** 0.3.1
🗓 **Date:** May 13, 2025

👉 [Previous APK release](https://drive.google.com/file/d/13BONsSSbAVDA-2E9rYyRQPih6Nd2p_nc/view?usp=drive_link)
🕘 **Previous version:** 0.2.3

---

## 🎯 Project Goals

- Serve as a learning tool for students new to Flutter and mobile development.
- Provide a real-world case study of authentication, state management, and REST API usage in Flutter.
- Foster contributions from the 42 global community to expand and evolve the app.
- Support a growing range of use cases "out of the box" including:
    - League and tournament management
    - Campus-specific dashboards and metrics
    - Web versions and extensions
    - Connectivity with smart devices (IoT) and domotics

Feel free to fork and experiment!

---

## 🏗️ Built With

- Flutter 3.22+
- Bloc / Cubit for state management
- Supabase for backend and authentication
- OAuth2 integration with 42 API
- Clean Architecture & Feature-based folder structure

---

## 📍 Currently Supported Campuses

Everything should work correctly on any of the 42 Network campuses, except for the information of users connected to the campus, which can only be viewed on those that are mapped.

The following campuses have defined cluster layouts:

- 🇪🇸 Málaga
- 🇪🇸 Madrid
- 🇪🇸 Urduliz
- 🇪🇸 Barcelona
- 🇫🇷 Angoulême

Want to add your campus cluster design? It only takes a few minutes, and you'll be listed as your campus ambassador in the app when the titles are implemented.
Just follow the template in `assets/campus_layouts`.

---

The app currently supports:

- English (default)
- Spanish
- French

Contributions for new languages are welcome!  
Add your translation files under `assets/translations` using the existing JSON format.

---

## 🙋‍♂️ Contributing

Mi Fortitú is open to contributions of all kinds:

- New features and modules
- Campus maps and layouts
- Translations and accessibility
- UI/UX improvements
- Staff/admin panel tools
- Bug fixes and performance enhancements

---

## 🔒 Access & Permissions

This app integrates both:

- 🔐 42 OAuth2 for secure student login
- 🛡️ Supabase auth + custom RLS (Row-Level Security) for internal roles (e.g., admin, moderator)

Note: To prevent API misuse, new users must be manually approved in-app.

---

## 📚 Documentation & Guide

Mi Fortitú also serves as a reference app for Flutter students. The codebase is modular, documented (in progress), and follows best practices (Clean Architecture, dependency injection, etc.).

You're encouraged to explore and learn from the project—even if you're not actively contributing.

---

## 💡 What's Next?

In the future, we plan to:

- Connect with Google Play for public distribution
- Add a dashboard for admins and staff
- Enable local avatar cloud sync
- Include real-time notifications and chat features
- Integrate usage metrics and performance analytics
- Make it exportable to other platforms (Linux, MacOS, iOS, ...)

---

## 🧠 By Students, For Students

Mi Fortitú is a tool created to empower 42 students globally. Whether you're a beginner or an experienced developer, there's a place for you to contribute.

Stay tuned, fork the repo, and let's build something great together 💙

---

© 2025 – Developed with ❤️ by 42 students