# Plan de Correcciones - Proyecto Flutter LOZCAM S.A.C.

## Errores identificados y correcciones a realizar:

### 1. Archivos con espacio en el nombre
- [ ] 1.1 Crear `lib/models/producto_model.dart` (renombrar desde `Producto_model .dart`)
- [ ] 1.2 Crear `lib/models/digi_model.dart` (renombrar desde `digi_model .dart` si existe)

### 2. Corregir tienda_service.dart
- [ ] 2.1 Corregir import de producto_model.dart
- [ ] 2.2 Cambiar `productoModel` por `ProductoModel`
- [ ] 2.3 Corregir la llamada a setToken()

### 3. Actualizar dio_client.dart
- [ ] 3.1 Agregar método setToken() para autenticación
- [ ] 3.2 Agregar método getToken() para recuperar token

### 4. Corregir main.dart
- [ ] 4.1 Implementar go_router para navegación
- [ ] 4.2 Integrar servicios de tienda correctamente

### 5. Verificar otros archivos
- [ ] 5.1 Verificar que todas las importaciones estén correctas
- [ ] 5.2 Probar que el proyecto compile sin errores
