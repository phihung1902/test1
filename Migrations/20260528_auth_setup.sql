-- Run once on boat_tour database before using auth APIs

CREATE TABLE IF NOT EXISTS email_verification_tokens (
    id CHAR(36) NOT NULL,
    email VARCHAR(255) NOT NULL,
    token_hash VARCHAR(64) NOT NULL,
    purpose VARCHAR(20) NOT NULL,
    expires_at DATETIME(6) NOT NULL,
    used_at DATETIME(6) NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    INDEX idx_email_verify_token_email_purpose (email, purpose),
    INDEX idx_email_verify_token_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- If column already exists, skip or comment out the next line
ALTER TABLE users ADD COLUMN email_verified_at DATETIME(6) NULL;

-- Ensure default roles exist
INSERT IGNORE INTO roles (name, description, created_at) VALUES
  ('user', 'Regular user', UTC_TIMESTAMP(6)),
  ('owner', 'Boat owner', UTC_TIMESTAMP(6)),
  ('admin', 'Administrator', UTC_TIMESTAMP(6));
