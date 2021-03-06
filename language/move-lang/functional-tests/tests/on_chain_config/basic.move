module ConfigHolder {
    use 0x1::LibraConfig;
    resource struct Holder<T> {
        cap: LibraConfig::ModifyConfigCapability<T>
    }

    public fun hold<T>(account: &signer, cap: LibraConfig::ModifyConfigCapability<T>) {
        move_to(account, Holder<T>{ cap })
    }

    public fun get<T>(): LibraConfig::ModifyConfigCapability<T>
    acquires Holder {
        let Holder<T>{ cap } = move_from<Holder<T>>({{config}});
        cap
    }
}

//! new-transaction
script {
    use 0x1::LibraConfig;
    fun main(account: &signer) {
        LibraConfig::initialize(account, account);
    }
}
// check: ABORTED
// check: 1

//! new-transaction
script {
    use 0x1::LibraConfig;
    fun main() {
        let _x = LibraConfig::get<u64>();
    }
}
// check: ABORTED
// check: 24

//! new-transaction
script {
    use 0x1::LibraConfig;
    fun main(account: &signer) {
        LibraConfig::set(account, 0);
    }
}
// check: ABORTED
// check: 24

//! new-transaction
script {
    use 0x1::LibraConfig;
    use {{default}}::ConfigHolder;
    fun main(account: &signer) {
        ConfigHolder::hold(
            account,
            LibraConfig::publish_new_config_with_capability(account, 0)
        );
    }
}
// check: ABORTED
// check: 1

//! new-transaction
//! sender: config
script {
    use 0x1::LibraConfig;
    use {{default}}::ConfigHolder;
    fun main(account: &signer) {
        ConfigHolder::hold(
            account,
            LibraConfig::publish_new_config_with_capability<u64>(account, 0)
        );
    }
}
// check: EXECUTED

//! new-transaction
script {
    use 0x1::LibraConfig;
    use {{default}}::ConfigHolder;
    fun main(account: &signer) {
        let cap = ConfigHolder::get<u64>();
        LibraConfig::set_with_capability(&cap, 0);
        ConfigHolder::hold(account, cap);
    }
}
// check: EXECUTED

//! new-transaction
script {
    use 0x1::LibraConfig;
    fun main(account: &signer) {
        LibraConfig::publish_new_config(account, 0)
    }
}
// check: ABORTED
// check: 1

//! new-transaction
script {
    use 0x1::LibraConfig;
    fun main(account: &signer) {
        LibraConfig::publish_new_config_with_delegate(account, 0, {{config}})
    }
}
// check: ABORTED
// check: 1
