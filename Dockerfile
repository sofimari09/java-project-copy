FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Створення користувача (опціонально)
RUN groupadd kestra && \
    useradd -m -g kestra kestra

# Копіюємо код програми
COPY --chown=kestra:kestra docker /

# Оновлення пакетів і установка необхідних залежностей (за потреби)
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Встановлення власника робочого каталогу
RUN chown -R kestra:kestra /app

# Використовуємо користувача `kestra`
USER kestra

# Вхідна точка
ENTRYPOINT ["docker-entrypoint.sh"]

# Команда за замовчуванням
CMD ["--help"]
