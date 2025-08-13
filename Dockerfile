# Utiliser une image Python officielle légère
FROM python:3.11-alpine

# Installer les dépendances système nécessaires
RUN apk add --no-cache gcc musl-dev linux-headers

# Copier les fichiers requirements.txt
COPY requirements.txt /tmp/

# Installer les dépendances Python
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copier tout le code de l'application dans le conteneur
COPY . /app

# Définir le répertoire de travail
WORKDIR /app/webapp

# Exposer le port sur lequel l'application va tourner
EXPOSE 5000

# Commande pour lancer Gunicorn en ciblant wsgi:application
CMD ["gunicorn", "wsgi:application", "--bind", "0.0.0.0:5000"]
