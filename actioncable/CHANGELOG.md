*   Add `ActionCable::Channel#stop_stream_from` and `#stop_stream_for` to unsubscribe from a specific stream.

    *Zhang Kang*

*   Add PostgreSQL subscription connection identificator.

    Now you can distinguish Action Cable PostgreSQL subscription connections among others.
    Also, you can set custom `id` in `cable.yml` configuration.

    ```sql
    SELECT application_name FROM pg_stat_activity;
    /*
        application_name
    ------------------------
    psql
    ActionCable-PID-42
    (2 rows)
    */
    ```

    *Sergey Ponomarev*

*   Subscription confirmations and rejections are now logged at the `DEBUG` level instead of `INFO`.

    *DHH*


Please check [6-0-stable](https://github.com/rails/rails/blob/6-0-stable/actioncable/CHANGELOG.md) for previous changes.
