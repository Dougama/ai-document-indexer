# AI Document Indexer

Servicio independiente para la indexación automática de documentos PDF usando embeddings vectoriales.

## Descripción

Este servicio procesa documentos PDF subidos a Cloud Storage, extrae su contenido, genera embeddings vectoriales y los almacena en Firestore Vector Search para búsquedas semánticas.

## Arquitectura

- **Trigger**: Cloud Storage events (PDF upload)
- **Processing**: Extracción de texto, chunking con overlap, generación de embeddings
- **Storage**: Firestore Vector Search
- **AI Model**: Google GenAI text-embedding-004

## Configuración

### Variables de Entorno Requeridas

```bash
GCP_PROJECT_ID=backend-developer-446300
GCP_LOCATION=us-central1
GEMINI_API_KEY=your-api-key
STORAGE_BUCKET=ia-agent
```

### Dependencias

- Google Cloud Functions Framework
- Google Cloud Storage
- Google Cloud Firestore
- Google GenAI
- PDF Parse

## Instalación

```bash
npm install
```

## Desarrollo Local

```bash
npm run start
```

## Build

```bash
npm run build
```

## Deploy

```bash
npm run deploy
```

## Funcionalidades

### Procesamiento de PDF
- ✅ Extracción de texto completo
- ✅ Chunking inteligente con overlap
- ✅ Generación de embeddings por batch
- ✅ Indexación en Firestore Vector Search
- 🔄 Extracción de imágenes (pendiente)

### Optimizaciones
- Chunking con superposición para mejor contexto
- Batch processing para reducir llamadas API
- Manejo de errores robusto
- Logging detallado

## API

### Cloud Function: `pdfIndexer`

Función que se ejecuta automáticamente cuando se sube un PDF a Cloud Storage.

**Trigger Event:**
```json
{
  "bucket": "ia-agent",
  "name": "document.pdf",
  "contentType": "application/pdf"
}
```

**Proceso:**
1. Descarga PDF de Cloud Storage
2. Extrae texto usando pdf-parse
3. Divide en chunks con overlap
4. Genera embeddings vectoriales
5. Indexa en Firestore Vector Search

## Monitoring

### Logs
```bash
gcloud functions logs read pdfIndexer --limit 50
```

### Métricas
- Documentos procesados
- Tiempo de procesamiento
- Errores de indexación
- Uso de tokens API

## Troubleshooting

### Errores Comunes

**PDF no procesado:**
- Verificar que el archivo sea PDF válido
- Confirmar permisos de Cloud Storage
- Revisar logs de la función

**Error de embeddings:**
- Verificar API key de Gemini
- Confirmar cuotas de API
- Revisar formato del texto

**Error de Firestore:**
- Verificar permisos de Firestore
- Confirmar configuración del proyecto
- Revisar estructura de documentos

## Estructura del Proyecto

```
src/
├── index.ts              # Cloud Function principal
├── steps/
│   └── embedding.ts      # Lógica de chunking y embeddings
└── types/
    └── genai.ts          # Definiciones de tipos
```

## Próximos Pasos

- [ ] Implementar extracción de imágenes con Gemini Vision
- [ ] Agregar soporte para otros formatos (DOCX, TXT)
- [ ] Implementar reindexación de documentos
- [ ] Agregar métricas de calidad de embeddings