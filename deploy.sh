#!/bin/bash

# Obtener el proyecto actual de gcloud
CURRENT_PROJECT=$(gcloud config get-value project)
echo "Desplegando al proyecto: $CURRENT_PROJECT"

# Build del proyecto
npm run build

# Deploy de la función
gcloud functions deploy pdfIndexer \
  --gen2 \
  --runtime=nodejs20 \
  --region=us-central1 \
  --source=. \
  --entry-point=pdfIndexer \
  --trigger-event-filters type=google.cloud.storage.object.v1.finalized \
  --trigger-event-filters bucket=ai-agent-cucuta