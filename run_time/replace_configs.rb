pg_credentials=["POSTGRES_USER_NAME",
                "POSTGRES_PASSWORD",
                "POSTGRES_HOST"].map { |key| key+"="+ENV[key] }

File.open("/root/.bashrc", 'w') { |file| file.write(pg_credentials.join("\n")) }
# code above adds pg credentials to bashrc so the start script of cubes will pick them up and replace them

