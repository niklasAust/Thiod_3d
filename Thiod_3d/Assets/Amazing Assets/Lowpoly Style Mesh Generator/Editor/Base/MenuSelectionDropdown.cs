// Lowpoly Style Mesh Generator <https://u3d.as/2z0X>
// Copyright (c) Amazing Assets <https://amazingassets.world>
 
using System;
using System.Linq;
using System.Collections.Generic;

using UnityEngine;
using UnityEditor;
using UnityEditor.IMGUI.Controls;


namespace AmazingAssets.LowpolyStyleMeshGenerator.Editor
{
	internal class MenuSelectionDropdown : AdvancedDropdown
	{
		private class MenuDropdownItem : AdvancedDropdownItem
		{
			public GUIContent selectedOption;

			public MenuDropdownItem(string itemName, GUIContent guiContent, bool isSelected)
				: base(itemName)
			{
				this.selectedOption = guiContent;
				base.id = guiContent.GetHashCode();


				if (isSelected)
					this.icon = EditorResources.IconSelected;
			}
		}




		static private float m_SpaceSize = EditorStyles.label.CalcSize(new GUIContent(" ")).x;

		string m_Title;
		static List<GUIContent> m_Properties;
		static string m_SelectedOption;
		private Action<object> m_CallbackMethod;
		private float m_MaxTextSize;

		public MenuSelectionDropdown(string title, List<GUIContent> properties, string selectedOptions, Action<object> callbackMethod)
			: base(new AdvancedDropdownState())
		{
			base.minimumSize = new Vector2(270f, 308f);

			m_Title = title;
			m_Properties = properties;
			m_SelectedOption = selectedOptions;
			m_CallbackMethod = callbackMethod;

			if (properties != null && properties.Count > 0)
				m_MaxTextSize = EditorStyles.label.CalcSize(properties.OrderByDescending(c => c.text.Length).FirstOrDefault()).x;
		}

		protected override void ItemSelected(AdvancedDropdownItem item)
		{
			m_CallbackMethod(((MenuDropdownItem)item).selectedOption);
		}

		protected override AdvancedDropdownItem BuildRoot()
		{
			AdvancedDropdownItem root = new AdvancedDropdownItem(m_Title);

			root.AddChild(new MenuDropdownItem(GetMenuDropdownItemName("None", string.Empty), new GUIContent("None"), string.IsNullOrEmpty(m_SelectedOption)));
			root.AddSeparator();

			foreach (var item in m_Properties)
			{
				MenuDropdownItem shaderDropdownItem = new MenuDropdownItem(GetMenuDropdownItemName(item.text, item.tooltip), item, string.IsNullOrEmpty(m_SelectedOption) ? false : item.text == m_SelectedOption);

				root.AddChild(shaderDropdownItem);
			}

			return root;
		}


		string GetMenuDropdownItemName(string text, string tooltip)
		{
			if (string.IsNullOrEmpty(tooltip))
				return string.Format("   {0}", text);
			else
			{
				float currentTextSize = EditorStyles.label.CalcSize(new GUIContent(text)).x;
				int spaceNeed = (int)((m_MaxTextSize - currentTextSize) / Mathf.Max(m_SpaceSize, 1));
				string space = spaceNeed >= 1 ? new string(' ', spaceNeed) : string.Empty;

				return $"   {text}   {space}\t\"{tooltip}\"";
			}
		}
	}
}