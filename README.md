# Laboratorio 7 · Fotos en el muro

Entrega del **Laboratorio 7** del curso de Aplicaciones Móviles (Flutter + Supabase).
Autor: **Luciano Barbosa** ([@Luciano1205](https://github.com/Luciano1205)).

La app es el muro del Laboratorio 6 (registro, inicio de sesión, publicaciones y «me gusta») con fotos:

- **Parte 1 · Foto de perfil.** Cada persona elige una foto de la galería. La foto aparece en su perfil y junto a cada uno de sus posts.
- **Parte 2 · Posts con imagen.** El composer deja adjuntar una foto, mostrarla antes de publicar y quitarla. Un post puede ser solo texto, solo foto o las dos cosas.

Las fotos de perfil van en el bucket **público** `avatars` y se muestran con una URL fija. Las de los posts van en el bucket **privado** `post-images` y solo las ve quien inició sesión, con URLs firmadas que vencen en una hora.

## Punto de partida y colaboradores del repositorio

El trabajo arrancó del proyecto base que entregó el profesor: [Domiciano/Apps262Lab7](https://github.com/Domiciano/Apps262Lab7). Ese proyecto trae el Laboratorio 6 resuelto, toda la interfaz de las fotos, las entidades, los contratos, los eventos y los estados, y deja vacíos los métodos de cada capa (`throw UnimplementedError()`).

Al clonarlo se copió también su historial de commits. Esos commits son del profesor (**Domiciano**) y varios incluyen la línea `Co-Authored-By: Claude`, por eso GitHub mostró a **Domiciano** y a **Claude** como contributors. Después se reemplazó ese historial por un único commit inicial, así que todos los commits de este repositorio quedan a mi nombre. La lista de contributors de GitHub tarda en actualizarse y puede seguir mostrándolos un tiempo.

## Qué se implementó

### Configuración

- Proyecto de Supabase propio conectado con `supabase link`, y `config.toml` con Auth por email y los dos buckets.
- Migraciones en `supabase/migrations/`:
  - `create_posts` y `create_likes`: las tablas del Laboratorio 6, que no estaban en el proyecto.
  - `create_avatars`: columna `profiles.avatar_path` y política de Storage para `avatars`.
  - `create_post_images`: columna `posts.image_path` y política de Storage para `post-images`.

### Parte 1 · Foto de perfil

| Capa | Archivo | Qué hace |
|---|---|---|
| Datos | `avatar/data/source/device_photo_data_source.dart` | Abre la galería con `image_picker` (512 px, calidad 80) y devuelve un `PickedPhoto`. Es el único archivo que conoce `image_picker`. |
| Datos | `avatar/data/source/supabase_avatar_data_source.dart` | Sube a `avatars/<uid>/<uuid>.<ext>` y borra archivos. El nombre UUID evita que las cachés muestren una foto vieja. |
| Datos | `avatar/data/repository/avatar_repository_impl.dart` | Cumple `AvatarRepository` delegando en los dos data sources. |
| Datos | `auth/data/source/supabase_profile_data_source.dart` | `updateAvatarPath`, y `getProfile` arma la URL pública con `getPublicUrl`. |
| Datos | `posts/data/source/supabase_post_data_source.dart` | Trae `avatar_path` del autor y arma `authorAvatarUrl`. |
| Dominio | `avatar/domain/usecases/change_avatar_usecase.dart` | Elige la foto, rechaza las de más de 2 MB, sube la nueva, apunta el perfil a ella y borra la anterior, en ese orden. |
| UI | `home/ui/bloc/feed_bloc.dart` | Emite `uploading` → `idle` o `failure` y recarga el muro. |
| UI | `home/ui/screens/home_screen.dart` | El botón de cámara lanza `AvatarChangeRequested`. |

### Parte 2 · Posts con imagen

| Capa | Archivo | Qué hace |
|---|---|---|
| Datos | `posts/data/source/supabase_post_image_data_source.dart` | Sube a `post-images` y pide URLs firmadas con `createSignedUrl` (3600 s). |
| Datos | `posts/data/repository/post_repository_impl.dart` | `pickImage`, `uploadImage` e `imageUrl`, reutilizando el data source de la galería de la parte 1. |
| Datos | `posts/data/source/supabase_post_data_source.dart` | Guarda y lee `image_path`. No arma URLs. |
| Dominio | `posts/domain/usecases/pick_post_image_usecase.dart` | Pide la foto y valida los 2 MB. |
| Dominio | `posts/domain/usecases/publish_post_usecase.dart` | Exige texto o foto, sube la foto primero y luego crea el post. |
| Dominio | `get_feed_usecase.dart` y `get_my_posts_usecase.dart` | Completan cada post con su URL firmada, todas a la vez con `Future.wait`. |
| UI | `compose/ui/bloc/compose_bloc.dart` | Agregar foto, quitarla y publicar con ella. |
| UI | `compose/ui/screens/compose_screen.dart` | El botón *Agregar foto* lanza `ComposePhotoRequested`. |

## Pruebas realizadas

**Parte 1**
- Subir una foto: aparece en el perfil y en los posts propios. En `Storage > avatars` queda la carpeta del usuario con un archivo UUID.
- Cambiar la foto: se ve la nueva y en la carpeta queda un solo archivo.
- Abrir la galería y cancelar: no pasa nada.
- Desde otra cuenta: los posts muestran la foto del autor.
- La URL pública de la foto abre sin sesión (`200`).

**Parte 2**
- Publicar sin texto ni foto: muestra *Escribe algo o agrega una foto*.
- Agregar una foto, quitarla y agregar otra: la vista previa sigue cada cambio.
- Publicar solo con foto y con texto y foto: los dos aparecen en el muro con su imagen.
- En `Storage > post-images` (privado) queda la carpeta del usuario, y la URL pública de la imagen responde `400`.

## Cómo correrlo

1. En `lib/main.dart` van la `Project URL` y la `publishable key` del proyecto de Supabase.
2. Con la CLI de Supabase vinculada al proyecto:

```bash
npx supabase seed buckets --remote
npx supabase db push --remote
```

3. Corre la app:

```bash
flutter pub get
flutter run
```
