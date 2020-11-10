IF version() ~ '12' or version() ~ '13' THEN
IF NOT EXISTS (SELECT 1 FROM pg_am WHERE amname = 'cstore_tableam') THEN

#include "../cstore_tableam_handler/10.0-1.sql"


#include "../alter_cstore_table_set/10.0-1.sql"

#include "../alter_cstore_table_reset/10.0-1.sql"

    -- add the missing objects to the extension
    ALTER EXTENSION citus ADD FUNCTION cstore.cstore_tableam_handler(internal);
    ALTER EXTENSION citus ADD ACCESS METHOD cstore_tableam;
    ALTER EXTENSION citus ADD FUNCTION pg_catalog.alter_cstore_table_set(
        table_name regclass,
        block_row_count int,
        stripe_row_count int,
        compression name);
    ALTER EXTENSION citus ADD FUNCTION pg_catalog.alter_cstore_table_reset(
        table_name regclass,
        block_row_count bool,
        stripe_row_count bool,
        compression bool);

END IF;
END IF;
