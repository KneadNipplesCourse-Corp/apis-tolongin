import sqlite3 from 'sqlite3';
import sha256 from 'sha256';

const DBSOURCE = "db.sqlite";
sqlite3.verbose();

const db = new sqlite3.Database(DBSOURCE, (err) => {
    if (err) {
        console.error("❌ Failed to connect to database:", err.message);
        throw err;
    } else {
        console.log("✅ Connected to SQLite database.");

        // User table
        db.run(`CREATE TABLE IF NOT EXISTS user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT
        )`, (err) => {
            if (err) {
                console.error("❌ Failed to create 'user' table:", err.message);
            } else {
                console.log("✅ User table ready.");
                const insert = `INSERT OR IGNORE INTO user (name, email, password) VALUES (?, ?, ?)`;
                db.run(insert, ["admin", "apis@gmail.com", sha256("123")]);
                db.run(insert, ["user", "user@example.com", sha256("P@ssw0rd")]);
            }
        });

        // Luxury Watch table
        db.run(`CREATE TABLE IF NOT EXISTS luxury_watch (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            model_name TEXT UNIQUE,
            brand TEXT,
            movement_type TEXT,
            case_material TEXT,
            water_resistance_meters INTEGER,
            price REAL,
            discount_percentage REAL,
            rating REAL,
            stock INTEGER,
            thumbnail TEXT,
            images TEXT
        )`, (err) => {
            if (err) {
                console.error("❌ Failed to create 'luxury_watch' table:", err.message);
            } else {
                console.log("✅ Luxury watch table ready.");
                const insert = `INSERT OR IGNORE INTO luxury_watch 
                    (model_name, brand, movement_type, case_material, water_resistance_meters, price, discount_percentage, rating, stock, thumbnail, images) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

                db.run(insert, [
                    "Submariner Date",
                    "Rolex",
                    "Automatic",
                    "Oystersteel",
                    300,
                    150000000,
                    0,
                    4.9,
                    5,
                    "https://example.com/images/rolex_submariner_thumb.jpg",
                    "https://example.com/images/rolex_submariner_1.jpg"
                ]);
            }
        });

        // Product table
        db.run(`CREATE TABLE IF NOT EXISTS product (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            price REAL,
            discountPercentage REAL,
            rating REAL,
            stock INTEGER,
            brand TEXT,
            category TEXT,
            thumbnail TEXT,
            images TEXT
        )`, (err) => {
            if (err) {
                console.error("❌ Failed to create 'product' table:", err.message);
            } else {
                console.log("✅ Product table ready.");
                const insert = `INSERT OR IGNORE INTO product 
                (title, description, price, discountPercentage, rating, stock, brand, category, thumbnail, images) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

                const products = [
                    ["Jam Tangan Elegant", "Jam tangan elegan dengan desain klasik", 1200000, 10, 4.5, 15, "Rolex", "Luxury", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/96/MTA-42275544/wwoor_wwoor_8812_classic_luxury_-_jam_tangan_elegan-_klasik_-_formal-_pria_-_stainless_steel_-_tahan_air_full15_x49sptw.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/96/MTA-42275544/wwoor_wwoor_8812_classic_luxury_-_jam_tangan_elegan-_klasik_-_formal-_pria_-_stainless_steel_-_tahan_air_full15_x49sptw.jpg"],
                    ["Jam Tangan Sporty", "Jam tangan sporty untuk aktivitas outdoor", 950000, 5, 4.2, 20, "Casio", "Sport", "https://example.com/images/jam2_thumb.jpg", "https://example.com/images/jam2.jpg"],
                    ["Jam Tangan Digital", "Jam tangan digital modern dengan fitur stopwatch", 800000, 7, 4.0, 18, "G-Shock", "Digital", "https://example.com/images/jam3_thumb.jpg", "https://example.com/images/jam3.jpg"],
                    ["Jam Tangan Mewah Kulit", "Jam tangan dengan strap kulit asli dan casing emas", 3500000, 12, 4.8, 10, "Fossil", "Luxury", "https://example.com/images/jam4_thumb.jpg", "https://example.com/images/jam4.jpg"],
                    ["Jam Tangan Anak", "Jam tangan lucu dan ringan untuk anak-anak", 300000, 5, 4.1, 25, "Flik Flak", "Kids", "https://example.com/images/jam5_thumb.jpg", "https://example.com/images/jam5.jpg"],
                    ["Jam Tangan Pintar", "Smartwatch dengan sensor kesehatan dan GPS", 2200000, 8, 4.6, 12, "Samsung", "Smart", "https://example.com/images/jam6_thumb.jpg", "https://example.com/images/jam6.jpg"]
                ];

                for (const p of products) {
                    db.run(insert, p);
                }
            }
        });
    }
});

export default db;
