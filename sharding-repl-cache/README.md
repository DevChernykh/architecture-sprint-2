# Задание 4. Кэширование

1. Поднять контейнеры
    ```bash
    docker compose up -d
    ```

2. Запустить скрипт инициализации
    ```bash
    bash ./scripts/mongo-init.sh 
    ```

3. Наполнить данными
    ```bash
    bash ./scripts/mongo-fill-data.sh
    ```

4. Перейти на страницу 127.0.0.1:8080 и проверить что всё работает

5. Проверить данные по шардам
    ```bash
    bash ./scripts/mongo-test.sh
    ```