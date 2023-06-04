terraform {
    backend "s3" {
        bucket = "renewablecarbon-s3"
        key    = "state.tfstate"
    }
}