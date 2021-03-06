
<a name="0x1_ValidatorConfig"></a>

# Module `0x1::ValidatorConfig`

### Table of Contents

-  [Struct `Config`](#0x1_ValidatorConfig_Config)
-  [Struct `ValidatorConfig`](#0x1_ValidatorConfig_ValidatorConfig)
-  [Function `publish`](#0x1_ValidatorConfig_publish)
-  [Function `set_operator`](#0x1_ValidatorConfig_set_operator)
-  [Function `remove_operator`](#0x1_ValidatorConfig_remove_operator)
-  [Function `set_config`](#0x1_ValidatorConfig_set_config)
-  [Function `set_consensus_pubkey`](#0x1_ValidatorConfig_set_consensus_pubkey)
-  [Function `is_valid`](#0x1_ValidatorConfig_is_valid)
-  [Function `get_config`](#0x1_ValidatorConfig_get_config)
-  [Function `get_operator`](#0x1_ValidatorConfig_get_operator)
-  [Function `get_consensus_pubkey`](#0x1_ValidatorConfig_get_consensus_pubkey)
-  [Function `get_validator_network_identity_pubkey`](#0x1_ValidatorConfig_get_validator_network_identity_pubkey)
-  [Function `get_validator_network_address`](#0x1_ValidatorConfig_get_validator_network_address)
-  [Function `decertify`](#0x1_ValidatorConfig_decertify)
-  [Function `certify`](#0x1_ValidatorConfig_certify)
-  [Function `is_certified`](#0x1_ValidatorConfig_is_certified)



<a name="0x1_ValidatorConfig_Config"></a>

## Struct `Config`



<pre><code><b>struct</b> <a href="#0x1_ValidatorConfig_Config">Config</a>
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>

<code>consensus_pubkey: vector&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>validator_network_identity_pubkey: vector&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>validator_network_address: vector&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>full_node_network_identity_pubkey: vector&lt;u8&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>full_node_network_address: vector&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_ValidatorConfig_ValidatorConfig"></a>

## Struct `ValidatorConfig`



<pre><code><b>resource</b> <b>struct</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a>
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>

<code>config: <a href="Option.md#0x1_Option_Option">Option::Option</a>&lt;<a href="#0x1_ValidatorConfig_Config">ValidatorConfig::Config</a>&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>operator_account: <a href="Option.md#0x1_Option_Option">Option::Option</a>&lt;address&gt;</code>
</dt>
<dd>

</dd>
<dt>

<code>is_certified: bool</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x1_ValidatorConfig_publish"></a>

## Function `publish`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_publish">publish</a>(creator: &signer, account: &signer)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_publish">publish</a>(creator: &signer, account: &signer) {
    <b>assert</b>(<a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(creator) == <a href="CoreAddresses.md#0x1_CoreAddresses_ASSOCIATION_ROOT_ADDRESS">CoreAddresses::ASSOCIATION_ROOT_ADDRESS</a>(), 1101);
    move_to(account, <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
        config: <a href="Option.md#0x1_Option_none">Option::none</a>(),
        operator_account: <a href="Option.md#0x1_Option_none">Option::none</a>(),
        is_certified: <b>true</b>
    });
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_set_operator"></a>

## Function `set_operator`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_operator">set_operator</a>(account: &signer, operator_account: address)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_operator">set_operator</a>(account: &signer, operator_account: address) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>let</b> sender = <a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(account);
    (borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(sender)).operator_account = <a href="Option.md#0x1_Option_some">Option::some</a>(operator_account);
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_remove_operator"></a>

## Function `remove_operator`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_remove_operator">remove_operator</a>(account: &signer)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_remove_operator">remove_operator</a>(account: &signer) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>let</b> sender = <a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(account);
    // <a href="#0x1_ValidatorConfig_Config">Config</a> field remains set
    (borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(sender)).operator_account = <a href="Option.md#0x1_Option_none">Option::none</a>();
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_set_config"></a>

## Function `set_config`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_config">set_config</a>(signer: &signer, validator_account: address, consensus_pubkey: vector&lt;u8&gt;, validator_network_identity_pubkey: vector&lt;u8&gt;, validator_network_address: vector&lt;u8&gt;, full_node_network_identity_pubkey: vector&lt;u8&gt;, full_node_network_address: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_config">set_config</a>(
    signer: &signer,
    validator_account: address,
    consensus_pubkey: vector&lt;u8&gt;,
    validator_network_identity_pubkey: vector&lt;u8&gt;,
    validator_network_address: vector&lt;u8&gt;,
    full_node_network_identity_pubkey: vector&lt;u8&gt;,
    full_node_network_address: vector&lt;u8&gt;,
) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(
        <a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(signer) == <a href="#0x1_ValidatorConfig_get_operator">get_operator</a>(validator_account),
        1101
    );
    // TODO(valerini): verify the validity of new_config.consensus_pubkey and
    // the proof of posession
    <b>let</b> t_ref = borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(validator_account);
    t_ref.config = <a href="Option.md#0x1_Option_some">Option::some</a>(<a href="#0x1_ValidatorConfig_Config">Config</a> {
        consensus_pubkey,
        validator_network_identity_pubkey,
        validator_network_address,
        full_node_network_identity_pubkey,
        full_node_network_address,
    });
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_set_consensus_pubkey"></a>

## Function `set_consensus_pubkey`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_consensus_pubkey">set_consensus_pubkey</a>(account: &signer, validator_account: address, consensus_pubkey: vector&lt;u8&gt;)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_set_consensus_pubkey">set_consensus_pubkey</a>(
    account: &signer,
    validator_account: address,
    consensus_pubkey: vector&lt;u8&gt;,
) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(
        <a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(account) == <a href="#0x1_ValidatorConfig_get_operator">get_operator</a>(validator_account),
        1101
    );
    <b>let</b> t_config_ref = <a href="Option.md#0x1_Option_borrow_mut">Option::borrow_mut</a>(&<b>mut</b> borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(validator_account).config);
    t_config_ref.consensus_pubkey = consensus_pubkey;
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_is_valid"></a>

## Function `is_valid`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_is_valid">is_valid</a>(addr: address): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_is_valid">is_valid</a>(addr: address): bool <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    exists&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr) && <a href="Option.md#0x1_Option_is_some">Option::is_some</a>(&borrow_global&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr).config)
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_get_config"></a>

## Function `get_config`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_config">get_config</a>(addr: address): <a href="#0x1_ValidatorConfig_Config">ValidatorConfig::Config</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_config">get_config</a>(addr: address): <a href="#0x1_ValidatorConfig_Config">Config</a> <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(exists&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr), 1106);
    <b>let</b> config = &borrow_global&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr).config;
    *<a href="Option.md#0x1_Option_borrow">Option::borrow</a>(config)
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_get_operator"></a>

## Function `get_operator`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_operator">get_operator</a>(addr: address): address
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_operator">get_operator</a>(addr: address): address <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(exists&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr), 1106);
    <b>let</b> t_ref = borrow_global&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr);
    *<a href="Option.md#0x1_Option_borrow_with_default">Option::borrow_with_default</a>(&t_ref.operator_account, &addr)
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_get_consensus_pubkey"></a>

## Function `get_consensus_pubkey`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_consensus_pubkey">get_consensus_pubkey</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">ValidatorConfig::Config</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_consensus_pubkey">get_consensus_pubkey</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">Config</a>): &vector&lt;u8&gt; {
    &config_ref.consensus_pubkey
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_get_validator_network_identity_pubkey"></a>

## Function `get_validator_network_identity_pubkey`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_validator_network_identity_pubkey">get_validator_network_identity_pubkey</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">ValidatorConfig::Config</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_validator_network_identity_pubkey">get_validator_network_identity_pubkey</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">Config</a>): &vector&lt;u8&gt; {
    &config_ref.validator_network_identity_pubkey
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_get_validator_network_address"></a>

## Function `get_validator_network_address`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_validator_network_address">get_validator_network_address</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">ValidatorConfig::Config</a>): &vector&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_get_validator_network_address">get_validator_network_address</a>(config_ref: &<a href="#0x1_ValidatorConfig_Config">Config</a>): &vector&lt;u8&gt; {
    &config_ref.validator_network_address
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_decertify"></a>

## Function `decertify`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_decertify">decertify</a>(account: &signer, addr: address)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_decertify">decertify</a>(account: &signer, addr: address) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(<a href="Association.md#0x1_Association_addr_is_association">Association::addr_is_association</a>(<a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(account)), 1002);
    borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr).is_certified = <b>false</b>;
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_certify"></a>

## Function `certify`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_certify">certify</a>(account: &signer, addr: address)
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_certify">certify</a>(account: &signer, addr: address) <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
    <b>assert</b>(<a href="Association.md#0x1_Association_addr_is_association">Association::addr_is_association</a>(<a href="Signer.md#0x1_Signer_address_of">Signer::address_of</a>(account)), 1002);
    borrow_global_mut&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr).is_certified = <b>true</b>;
}
</code></pre>



</details>

<a name="0x1_ValidatorConfig_is_certified"></a>

## Function `is_certified`



<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_is_certified">is_certified</a>(addr: address): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="#0x1_ValidatorConfig_is_certified">is_certified</a>(addr: address): bool <b>acquires</b> <a href="#0x1_ValidatorConfig">ValidatorConfig</a> {
     exists&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr) && borrow_global&lt;<a href="#0x1_ValidatorConfig">ValidatorConfig</a>&gt;(addr).is_certified
}
</code></pre>



</details>
